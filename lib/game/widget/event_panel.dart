import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:catrun/game/config/app_config.dart';
import 'package:catrun/game/event/event.dart';
import 'package:catrun/game/event/player_event.dart';
import 'package:catrun/game/manager/fight_mgr.dart';
import 'package:catrun/game/manager/player_mgr.dart';
import 'package:catrun/game/role/enemy.dart';
import 'package:catrun/game/role/player.dart';
import 'package:catrun/game/widget/fight_panel.dart';
import 'package:catrun/res/colors.dart';
import 'package:catrun/res/gaps.dart';
import 'package:catrun/res/styles.dart';
import 'package:catrun/router/routers.dart';
import 'package:catrun/utils/screen_util.dart';
import 'package:catrun/widget/animate/fade_in_text.dart';
import 'package:catrun/widget/animate/scale_widget.dart';
import 'package:catrun/widget/animate/type_writer_text.dart';
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

  Random _random = Random();
  int _count = 0;
  int _action = 0;
  bool _enableAction = true;

  List<String> _listStr = [];

  bool _practiceVisible = false;
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

    Player? player = PlayerMgr.instance()!.getPlayer();
    if ((player?.energy ?? 0) <= 0) {
      _action = 404;
    } else {
      _action = action;
      player?.energy = max((player.energy ?? 0) - 5, 0);

      if (_action == 2) {
        bool ret = _random.nextBool();
        if (ret) {
          _action = 201;
          Future.delayed(Duration(milliseconds: 500), () {
            setState(() {
              _fightVisible = true;
            });
          });
        } else {
          _action = 202;
          player?.hungry = (player.hungry ?? 0) + 20;
        }
      } else if (_action == 101) {
        player?.power = (player.power ?? 0) + 1;
        player?.attack = (player.attack ?? 0) + 2;
      } else if (_action == 102) {
        player?.physic = (player.physic ?? 0) + 1;
        player?.maxlife = (player.maxlife ?? 0) + 5;
        player?.defence = (player.defence ?? 0) + 1;
      } else if (_action == 103) {
        player?.skill = (player.skill ?? 0) + 1;
        player?.attack = (player.attack ?? 0) + 1;
        player?.defence = (player.defence ?? 0) + 1;
      }

      Event.eventBus.fire(PlayerEvent(player, PlayerEventState.update));
    }

    setState(() {
      _count = -1;

      Future.delayed(Duration(milliseconds: 100), () {
        setState(() {
          _count = 0;
        });
      });

    });
  }

  void startDisplayAction(int action) {

    _action = action;
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
            FadeInAnimatedText(entry.value, textStyle: TextStyles.textMain16_w700),
          ],
          onFinished: () {
            _enableAction = true;
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
        padding: EdgeInsets.symmetric(vertical: 5.dp),
        alignment: Alignment.center,
        child: AnimatedTextKit(
          totalRepeatCount: 1,
          displayFullTextOnTap: true,
          pause: AppConfig.textPauseDuration,
          animatedTexts: [
            TypeWriterAnimatedText(entry.value, textStyle: TextStyles.textMain16_w700),
          ],
          onFinished: () {
            _enableAction = true;
            setState(() {
              _count ++;
            });
          },
        ),
      ) : Gaps.empty;
    }).toList();
  }

  Widget _buildEvent(int action) {

    if (_action == 404) {
      _listStr = ['精神不足，该休息了'];
    } else if (_action == 201) {
      _listStr = ['遇到大魔王'];
    } else if (_action == 202) {
      _listStr = ['捡到剩饭，饱食度+20'];
    } else if (_action == 3) {
      _listStr = [''];
    } else if (_action == 4) {
      //战斗结束
      _listStr = [_fightResult?.desc ?? ''];
    } else if (action == 101) {
      _listStr = ['力量+1，攻击力+2'];
    } else if (action == 102) {
      _listStr = ['体魄+1，生命值上限+5，防御力+1'];
    } else if (action == 103) {
      _listStr = ['灵巧+1，攻击力+1，防御力+1'];
    }

    return Column(children: _buildTyper(_listStr));
  }

  Widget _buildActionButton(String name, int action) {
    return BorderButton(width: 72.dp, height: 28.dp,
      text: name,
      textStyle: TextStyles.textMain12,
      color: Colours.transparent,
      borderColor: Colours.app_main,
      onPressed: () {
        if (action == 1) {
          setState(() {
            _practiceVisible = true;
          });
        } else if (action == 3) {
          startDisplayAction(action);
          Routers.navigateTo(context, Routers.timePage);

        } else if (action == 100) {
          setState(() {
            _practiceVisible = false;
          });
        } else {
          if (!_enableAction) {
            return;
          }
          _enableAction = false;

          startAction(action);
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {

    Widget actionPanel = ScaleWidget(
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

    Widget practicePanel = ScaleWidget(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionButton('返回', 100),
          _buildActionButton('力量', 101),
          _buildActionButton('体魄', 102),
          _buildActionButton('灵巧', 103),
        ],
      ),
    );

    return Stack(
      fit: StackFit.expand,
      children: [
        !_fightVisible ? ScaleWidget(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.dp, vertical: 20.dp),
            child: Column(
              children: [
                Expanded(child: _buildEvent(_action)),
                !_practiceVisible ? actionPanel : Gaps.empty,
                _practiceVisible ? practicePanel : Gaps.empty
              ],
            ),
          )
        ) : Gaps.empty,

        _fightVisible ? ScaleWidget(
          child: FightPanel(
            enemy: Enemy(),
            onFinish: (result) {
              _fightVisible = false;
              _fightResult = result;
              startDisplayAction(4);
            },
          ),
        ) : Gaps.empty

      ],
    );
  }
}
