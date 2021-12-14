import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:catrun/game/config/app_config.dart';
import 'package:catrun/game/event/event.dart';
import 'package:catrun/game/event/player_event.dart';
import 'package:catrun/game/manager/action_mgr.dart';
import 'package:catrun/game/manager/fight_mgr.dart';
import 'package:catrun/game/manager/player_mgr.dart';
import 'package:catrun/game/model/enemy.dart';
import 'package:catrun/game/model/player.dart';
import 'package:catrun/game/model/action.dart';
import 'package:catrun/game/widget/fight_panel.dart';
import 'package:catrun/generated/l10n.dart';
import 'package:catrun/res/colors.dart';
import 'package:catrun/res/gaps.dart';
import 'package:catrun/res/styles.dart';
import 'package:catrun/router/routers.dart';
import 'package:catrun/utils/screen_util.dart';
import 'package:catrun/widget/animate/fade_in_text.dart';
import 'package:catrun/widget/animate/scale_widget.dart';
import 'package:catrun/widget/animate/type_writer_text.dart';
import 'package:catrun/widget/button/border_button.dart';
import 'package:flutter/material.dart' hide Action;

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
  Action? _action;
  bool _enableAction = true;


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

  void startAction(Action? action) {

    Player? player = PlayerMgr.instance()!.getPlayer();
    if ((player?.energy ?? 0) <= 0) {
      _action = ActionMgr.instance()!.getAction(Action.id_act_rest_need);
    } else {
      _action = action;
      player?.energy = max((player.energy ?? 0) - 5, 0);

      if (_action?.id == 2) {
        bool ret = _random.nextBool();
        if (ret) {
          _action!.id = 201;
          Future.delayed(Duration(milliseconds: 500), () {
            setState(() {
              _fightVisible = true;
            });
          });
        } else {
          _action!.id = 202;
          player?.hungry = (player.hungry ?? 0) + 20;
        }
      } else {
        PlayerMgr.instance()!.makeDiffs(action?.diffs ?? []);
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

  void startDisplayAction(Action? action) {

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

  Widget _buildEvent() {

    List<String> listStr = [''];
    if (_action?.id == Action.id_act_fight_finish) {
      listStr = [_fightResult?.desc ?? ''];
    } else {
      listStr = _action?.desc ?? [''];
    }

    return Column(children: _buildTyper(listStr));
  }

  Widget _buildActionButton(Action? action) {
    return BorderButton(width: 72.dp, height: 28.dp,
      text: action?.name,
      textStyle: TextStyles.textMain12,
      color: Colours.transparent,
      borderColor: Colours.app_main,
      onPressed: () {
        if (action?.id == Action.id_act_practice) {
          setState(() { _practiceVisible = true; });
        } else if (action?.id == Action.id_act_back) {
          setState(() { _practiceVisible = false; });

        } else if (action?.id == Action.id_act_rest) {
          startDisplayAction(action);
          Routers.navigateTo(context, Routers.timePage);

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
          _buildActionButton(ActionMgr.instance()!.getAction(Action.id_act_practice)),
          _buildActionButton(ActionMgr.instance()!.getAction(Action.id_act_goout)),
          _buildActionButton(ActionMgr.instance()!.getAction(Action.id_act_rest)),
        ],
      ),
    );

    Widget practicePanel = ScaleWidget(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionButton(ActionMgr.instance()!.getAction(Action.id_act_back)),
          _buildActionButton(ActionMgr.instance()!.getAction(Action.id_act_power)),
          _buildActionButton(ActionMgr.instance()!.getAction(Action.id_act_physic)),
          _buildActionButton(ActionMgr.instance()!.getAction(Action.id_act_skill)),
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
                Expanded(child: _buildEvent()),
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
              startDisplayAction(ActionMgr.instance()!.getAction(Action.id_act_fight_finish));
            },
          ),
        ) : Gaps.empty

      ],
    );
  }
}
