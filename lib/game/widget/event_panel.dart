import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:catrun/game/config/app_config.dart';
import 'package:catrun/game/manager/action_mgr.dart';
import 'package:catrun/game/model/action.dart';
import 'package:catrun/game/model/enemy.dart';
import 'package:catrun/game/viewmodel/event_model.dart';
import 'package:catrun/game/widget/fight_panel.dart';
import 'package:catrun/mvvm/provider_widget.dart';
import 'package:catrun/res/colors.dart';
import 'package:catrun/res/gaps.dart';
import 'package:catrun/res/styles.dart';
import 'package:catrun/router/routers.dart';
import 'package:catrun/utils/screen_util.dart';
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

  late EventModel _eventModel;

  @override
  void initState() {
    super.initState();

    _eventModel = EventModel();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // void startAction(Action? action) {
  //
  //   Player? player = PlayerMgr.instance()!.getPlayer();
  //   if ((player?.energy ?? 0) <= 0) {
  //     _action = ActionMgr.instance()!.getAction(Action.id_act_rest_need);
  //   } else {
  //     _action = action;
  //     player?.energy = max((player.energy ?? 0) - 5, 0);
  //
  //     if (_action?.id == 2) {
  //       bool ret = _random.nextBool();
  //       if (ret) {
  //         _action!.id = 201;
  //         Future.delayed(Duration(milliseconds: 500), () {
  //           setState(() {
  //             _fightVisible = true;
  //           });
  //         });
  //       } else {
  //         _action!.id = 202;
  //         player?.hungry = (player.hungry ?? 0) + 20;
  //       }
  //     } else {
  //       PlayerMgr.instance()!.makeDiffs(action?.diffs ?? []);
  //     }
  //
  //     Event.eventBus.fire(PlayerEvent(player, PlayerEventState.update));
  //   }
  //
  // }

  List<Widget> _buildTyper(List<String> listStr) {
    return listStr.asMap().entries.map((entry) {
      return _eventModel.animCount >= entry.key ? Container(
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
            _eventModel.animCount ++;
            if (_eventModel.animCount >= listStr.length) {
              _eventModel.finishAction();
            }
          },
        ),
      ) : Gaps.empty;
    }).toList();
  }

  Widget _buildActionButton(Action? action) {
    return BorderButton(width: 72.dp, height: 28.dp,
      text: action?.name,
      textStyle: TextStyles.textMain12,
      color: Colours.transparent,
      borderColor: Colours.app_main,
      onPressed: () {
        if (action?.id == Action.id_act_practice) {
          _eventModel.practiceVisible = true;
        } else if (action?.id == Action.id_act_back) {
          _eventModel.practiceVisible = false;
        } else if (action?.id == Action.id_act_rest) {
          _eventModel.startAction(action, burn: false);
          Routers.navigateTo(context, Routers.timePage);
        } else {
          _eventModel.startAction(action);
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<EventModel>(
        model: _eventModel,
        builder: (context, model, child) {
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
              !_eventModel.fightVisible ? ScaleWidget(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.dp, vertical: 20.dp),
                    child: Column(
                      children: [
                        Expanded(child: Column(children: _buildTyper(_eventModel.getActionStr()))),
                        !_eventModel.practiceVisible ? actionPanel : Gaps.empty,
                        _eventModel.practiceVisible ? practicePanel : Gaps.empty
                      ],
                    ),
                  )
              ) : Gaps.empty,

              _eventModel.fightVisible ? ScaleWidget(
                child: FightPanel(
                  enemy: _eventModel.enemy!,
                  onFinish: (result) {
                    _eventModel.fightVisible = false;
                    _eventModel.fightResult = result;
                    _eventModel.startAction(ActionMgr.instance()!.getAction(Action.id_act_fight_finish), burn: false);
                  },
                ),
              ) : Gaps.empty

            ],
          );
        });

  }
}
