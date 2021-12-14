
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:catrun/game/config/app_config.dart';
import 'package:catrun/game/page/main_page.dart';
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

class GameOver extends StatefulWidget {

  GameOver({
    Key? key,
  }): super(key: key);

  @override
  _GameOverState createState() => _GameOverState();
}

class _GameOverState extends State<GameOver> {

  int _count = 0;
  List<String> _listStr = [];

  @override
  void initState() {
    super.initState();
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
        alignment: Alignment.center,
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

  Widget _buildStory() {

    _listStr = ['饿死了，不玩了', '游戏结束'];

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
          Routers.navigateTo(context, Routers.menuPage, clearStack: true);
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
                Expanded(child: _buildStory()),
                _buildConfirmButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

}
