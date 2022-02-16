
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:catrun/game/manager/action_mgr.dart';
import 'package:catrun/game/manager/diary_mgr.dart';
import 'package:catrun/game/manager/enemy_mgr.dart';
import 'package:catrun/game/manager/npc_mgr.dart';
import 'package:catrun/game/manager/player_mgr.dart';
import 'package:catrun/game/manager/prop_mgr.dart';
import 'package:catrun/game/manager/revent_mgr.dart';
import 'package:catrun/game/manager/time_mgr.dart';
import 'package:catrun/game/model/player.dart';
import 'package:catrun/generated/l10n.dart';
import 'package:catrun/res/colors.dart';
import 'package:catrun/res/gaps.dart';
import 'package:catrun/res/styles.dart';
import 'package:catrun/router/routers.dart';
import 'package:catrun/utils/screen_util.dart';
import 'package:catrun/widget/animate/fade_in_text.dart';
import 'package:catrun/widget/button/gradient_button.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {

  const MenuPage({
    Key? key,
  }): super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<MenuPage> {
  bool showSplash = true;

  @override
  void initState() {
    super.initState();
    TimeMgr.instance()!.reset();
    DiaryMgr.instance()!.loadDiaries();
    ActionMgr.instance()!.loadActions();
    REventMgr.instance()!.loadREvents();
    EnemyMgr.instance()!.loadEnemys();
    PropMgr.instance()!.loadProps();
    NpcMgr.instance()!.loadNpcs();
  }

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
                colors: const [   //背景渐变
                  Colours.app_main,
                  Colours.app_main
                ],
                onPressed: () {
                  PlayerMgr.instance()!.setPlayer(Player());
                  Routers.navigateTo(context, Routers.diaryPage);
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
                      child: Text('JRY1009', style: TextStyles.textMain14),
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
                      child: Text('Flutter', style: TextStyles.textMain14),
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
            FadeInAnimatedText(S.of(context).appName,
                duration: Duration(milliseconds: 2000),
                textStyle: TextStyles.textMain32_w700)
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
