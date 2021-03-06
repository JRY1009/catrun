
import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:catrun/game/config/app_config.dart';
import 'package:catrun/game/manager/diary_mgr.dart';
import 'package:catrun/game/manager/player_mgr.dart';
import 'package:catrun/game/manager/time_mgr.dart';
import 'package:catrun/game/model/diary.dart';
import 'package:catrun/game/model/player.dart';
import 'package:catrun/generated/l10n.dart';
import 'package:catrun/res/colors.dart';
import 'package:catrun/res/gaps.dart';
import 'package:catrun/res/styles.dart';
import 'package:catrun/router/routers.dart';
import 'package:catrun/utils/screen_util.dart';
import 'package:catrun/widget/animate/fade_in_text.dart';
import 'package:catrun/widget/animate/scale_widget.dart';
import 'package:catrun/widget/button/border_button.dart';
import 'package:flutter/material.dart';

class TimePage extends StatefulWidget {

  TimePage({
    Key? key,
  }): super(key: key);

  @override
  _TimePageState createState() => _TimePageState();
}

class _TimePageState extends State<TimePage> {

  int _count = 0;
  List<String> _listStr = [];

  @override
  void initState() {
    super.initState();
    TimeMgr.instance()!.nextDay();

    startAction();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void startAction() {

    setState(() {
      _count = -1;

      Future.delayed(Duration(milliseconds: 100), () {
        setState(() {
          _count = 0;
        });
      });

    });
  }

  List<Widget> _buildFade(List<String> listStr) {
    return listStr.asMap().entries.map((entry) {
      return _count >= entry.key ? Container(
        padding: EdgeInsets.symmetric(vertical: 5.dp),
        alignment: entry.key == 0 ? Alignment.center : Alignment.centerLeft,
        child: AnimatedTextKit(
          totalRepeatCount: 1,
          displayFullTextOnTap: true,
          pause: AppConfig.textPauseDuration,
          animatedTexts: [
            FadeInAnimatedText(entry.value, textStyle: TextStyles.textWhite16_w700),
          ],
          onFinished: () {
            setState(() {
              _count ++;
            });
          },
        ),
      ) : Gaps.empty;
    }).toList();
  }

  Widget _buildDiary() {

    int day = TimeMgr.instance()!.getDay();
    Player? player = PlayerMgr.instance()!.getPlayer();

    _listStr = ['???${day}???', '????????????${player?.life}\n????????????${player?.hungry}\n?????????+50????????????-20',];

    return Column(children: _buildFade(_listStr));
  }

  Widget _buildConfirmButton() {
    return _count >= _listStr.length ? ScaleWidget(
      child: BorderButton(width: 108.dp, height: 36.dp,
        text: S.of(context).confirm,
        textStyle: TextStyles.textWhite16,
        color: Colours.transparent,
        borderColor: Colours.white,
        onPressed: () {

          Player? player = PlayerMgr.instance()!.getPlayer();
          int day = TimeMgr.instance()!.getDay();
          Diary? diary = DiaryMgr.instance()!.getDiary(day);
          if ((player?.hungry ?? 0) <= 0) {
            Routers.navigateTo(this.context, Routers.gameOver);
          } else if (diary != null) {
            Routers.goBack(context);
            Routers.navigateTo(this.context, Routers.diaryPage);
          } else {
            Routers.goBack(context);
          }
        },
      ),
    ) : Gaps.empty;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.dp, vertical: 20.dp),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(child: _buildDiary()),
                _buildConfirmButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

}
