import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:catrun/game/manager/fight_mgr.dart';
import 'package:catrun/game/role/enemy.dart';
import 'package:catrun/game/widget/fight_panel.dart';
import 'package:catrun/res/colors.dart';
import 'package:catrun/res/gaps.dart';
import 'package:catrun/res/styles.dart';
import 'package:catrun/utils/screen_util.dart';
import 'package:catrun/widget/animate/fade_in_text.dart';
import 'package:catrun/widget/button/border_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventPanel extends StatefulWidget {

  EventPanel({
    Key? key,
  }): super(key: key);

  @override
  EventPanelState createState() => EventPanelState();
}

class EventPanelState extends State<EventPanel> {

  int _count = 0;
  int _action = 0;
  List<String> _listStr = [];
  
  bool _fightVisible = false;
  Fight? _fightResult;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void startAction(int action) {

    setState(() {

      _action = action;
      _count = -1;

      Future.delayed(Duration(milliseconds: 100), () {
        setState(() {
          _count = 0;
        });
      });

    });
    
    if (action == 2) {

      Future.delayed(Duration(milliseconds: 1000), () {
        setState(() {
          _fightVisible = true;
        });
      });
    }
  }

  List<Widget> _buildFade(List<String> listStr) {
    return listStr.asMap().entries.map((entry) {
      return _count >= entry.key ? Container(
        alignment: Alignment.center,
        child: AnimatedTextKit(
          totalRepeatCount: 1,
          displayFullTextOnTap: true,
          animatedTexts: [
            FadeInAnimatedText(entry.value, textStyle: TextStyles.textMain16_w700),
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

  List<Widget> _buildTyper(List<String> listStr) {
    return listStr.asMap().entries.map((entry) {
      return _count >= entry.key ? Container(
        alignment: Alignment.center,
        child: AnimatedTextKit(
          totalRepeatCount: 1,
          displayFullTextOnTap: true,
          animatedTexts: [
            TyperAnimatedText(entry.value, textStyle: TextStyles.textMain16_w700),
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

  Widget _buildEvent(int action) {

    if (action == 1) {
      _listStr = ['锻炼事件锻炼事件锻炼事件锻炼事件1', '锻炼事件锻炼事件锻炼事件锻炼事件222222'];
      return Column(children: _buildFade(_listStr));
    } else if (_action == 2) {
      _listStr = ['遇到大魔王'];
      return Column(children: _buildTyper(_listStr));
    } else if (_action == 3) {
      _listStr = ['休息事件111', '休息事件2222221', '休息事件333'];
      return Column(children: _buildTyper(_listStr));
    } else if (_action == 4) {
      //战斗结束
      _listStr = [_fightResult?.desc ?? ''];
      return Column(children: _buildTyper(_listStr));
    }

    return Column(children: _buildTyper(_listStr));
  }

  Widget _buildActionButton(String name, int action) {
    return BorderButton(width: 72.dp, height: 28.dp,
      text: name,
      textStyle: TextStyles.textMain12,
      color: Colours.transparent,
      borderColor: Colours.app_main,
      onPressed: () => startAction(action),
    );
  }

  @override
  Widget build(BuildContext context) {

    Widget actionPanel = Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionButton('锻炼', 1),
          _buildActionButton('外出', 2),
          _buildActionButton('休息', 3),
        ],
      ),
    );

    return !_fightVisible ? Container(
      padding: EdgeInsets.symmetric(horizontal: 20.dp, vertical: 20.dp),
      child: Column(
        children: [
          Expanded(child: _buildEvent(_action)),
          actionPanel
        ],
      ),
    ) : FightPanel(
      enemy: Enemy(),
      onFinish: (result) {
        _fightVisible = false;
        _fightResult = result;
        startAction(4);
      },
    );
  }

}
