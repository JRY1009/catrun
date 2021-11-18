import 'dart:async';

import 'package:catrun/game/page/menu_page.dart';
import 'package:catrun/generated/l10n.dart';
import 'package:catrun/global/locale_provider.dart';
import 'package:catrun/global/theme_provider.dart';
import 'package:catrun/main_router.dart';
import 'package:catrun/mvvm/provider_widget.dart';
import 'package:catrun/res/colors.dart';
import 'package:catrun/router/app_analysis.dart';
import 'package:catrun/router/routers.dart';
import 'package:catrun/utils/channel_util.dart';
import 'package:catrun/utils/device_util.dart';
import 'package:catrun/utils/log_util.dart';
import 'package:catrun/utils/sp_util.dart';
import 'package:fl_umeng/fl_umeng.dart';
import 'package:flame/flame.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


//默认App的启动
class DefaultApp {
  static Future<Widget> getApp() async {
    WidgetsFlutterBinding.ensureInitialized();

    await initApp();

    return MyApp();
  }

  //运行app
  static Future<void> run() async {
    WidgetsFlutterBinding.ensureInitialized();

    await initApp();

    runApp(MyApp());
  }

  //程序初始化操作
  static Future<void> initApp() async {

    LogUtil.init(isDebug: true);
    //JPushUtil.initPlatformState();

    if (DeviceUtil.isAndroid) {
      // 透明状态栏
      const SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }

    if (DeviceUtil.isMobile) {

      String channel = await ChannelUtil.getChannel();

      await initWithUM(
          androidAppKey: '607552ba5844f15425d14f03',
          iosAppKey: '6075530a5844f15425d151b2',
          channel: channel
      );

      await setPageCollectionModeManualWithUM();

      await Flame.device.setPortrait();
      await Flame.device.fullScreen();
    }

    await SPUtil.init();
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();


    Routers.init([
      MainRouter(),
    ]);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return ProviderWidget2(
        model1: ThemeProvider(),
        model2: LocaleProvider(SPUtil.getString(SPUtil.key_locale)),
        builder: (context, dynamic themeProvider, dynamic localeModel, _) {

          Widget child = MaterialApp(
            title: 'CatRun',
            home: MenuPage(),
            theme:  themeProvider.getThemeData(),
            darkTheme: themeProvider.getThemeData(isDarkMode: true),
            themeMode: themeProvider.getThemeMode(),
            onGenerateRoute: Routers.router!.generator,
            navigatorObservers: [AppAnalysis()],
            locale: localeModel.getLocale(),
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            supportedLocales: S.delegate.supportedLocales,
            localeResolutionCallback: (Locale? _locale, Iterable<Locale> supportedLocales) {
              if (localeModel.getLocale() != null) {  //如果已经选定语言，则不跟随系统
                return localeModel.getLocale();

              } else {  //跟随系统
                if (S.delegate.isSupported(_locale!)) {
                  return _locale;
                }
                return supportedLocales.first;
              }
            },
            builder: (context, widget) {
              return MediaQuery(
                //设置文字大小不随系统设置改变
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!,
              );
            },
          );

          return child;
        }
    );
  }
}
