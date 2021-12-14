import 'dart:async' as async;

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:catrun/generated/l10n.dart';
import 'package:catrun/res/colors.dart';
import 'package:catrun/res/gaps.dart';
import 'package:catrun/res/styles.dart';
import 'package:catrun/router/routers.dart';
import 'package:catrun/utils/screen_util.dart';
import 'package:catrun/widget/animate/color_text.dart';
import 'package:catrun/widget/button/gradient_button.dart';
import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<MenuPage> {
  bool showSplash = true;
  int currentPosition = 0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: showSplash ? buildSplash() : buildMenu(),
    );
  }

  Widget buildMenu() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              S.of(context).appName,
              style: TextStyles.textMain24_w700,
            ),
            Gaps.vGap50,
            GradientButton(
                width: 150.dp,
                height: 48.dp,
                text: S.of(context).startGame,
                textStyle: TextStyles.textWhite16,
                colors: <Color>[   //背景渐变
                  Colours.app_main,
                  Colours.app_main
                ],
                onPressed: () {
                  Routers.navigateTo(context, Routers.storyPage);
                },
            )
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 20.dp,
          margin: EdgeInsets.all(20.dp),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('powered_by: ', style: TextStyles.textMain12),
                    InkWell(
                      onTap: () {},
                      child: Text('Unicode', style: TextStyles.textMain14),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('built_with: ', style: TextStyles.textMain12),
                    InkWell(
                      onTap: () {},
                      child: Text('Flame', style: TextStyles.textMain14),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSplash() {
    // return FlameSplashScreen(
    //   theme: FlameSplashTheme.white,
    //   onFinish: (BuildContext context) {
    //     setState(() {
    //       showSplash = false;
    //     });
    //   },
    // );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: AnimatedTextKit(
          totalRepeatCount: 1,
          animatedTexts: [
            ColorAnimatedText(
              S.of(context).appName,
              textStyle: TextStyles.textGray600_32_w700,
              speed: Duration(milliseconds: 500),
              colors: [
                Colours.gray_600,
                Colours.gray_200,
                Colours.gray_500,
                Colours.app_main,
              ],
            ),
          ],
          onFinished: () {
            setState(() {
              showSplash = false;
            });
          },
        ),
      ),
    );
  }
}
