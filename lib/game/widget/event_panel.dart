
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:catrun/game/config/app_config.dart';
import 'package:catrun/game/manager/action_mgr.dart';
import 'package:catrun/game/manager/player_mgr.dart';
import 'package:catrun/game/model/action.dart';
import 'package:catrun/game/model/player.dart';
import 'package:catrun/game/viewmodel/event_model.dart';
import 'package:catrun/generated/l10n.dart';
import 'package:catrun/mvvm/provider_widget.dart';
import 'package:catrun/res/colors.dart';
import 'package:catrun/res/gaps.dart';
import 'package:catrun/res/styles.dart';
import 'package:catrun/utils/object_util.dart';
import 'package:catrun/utils/screen_util.dart';
import 'package:catrun/widget/animate/scale_widget.dart';
import 'package:catrun/widget/animate/type_writer_text.dart';
import 'package:catrun/widget/button/border_button.dart';
import 'package:flutter/material.dart' hide Action;

import 'carry_panel.dart';
import 'fight_panel.dart';
import 'meet_panel.dart';
import 'prop_option_panel.dart';
import 'outside_panel.dart';

class EventPanel extends StatefulWidget {

  const EventPanel({
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
    _eventModel.listenEvent();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
            TypeWriterAnimatedText(entry.value, textAlign: TextAlign.center, textStyle: TextStyles.textMain16_w700),
          ],
          onFinished: () {
            _eventModel.animCount ++;
            if (_eventModel.animCount >= listStr.length - 1) {
              _eventModel.handleEvent();
            }

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
        _eventModel.doAction(context, action);
      }
    );
  }

  Widget _buildOptionButtons() {
    return ScaleWidget(
      child: Column(
        children: _eventModel.revent?.options?.asMap().entries.map((entry) {
          return Container(
            margin: EdgeInsets.only(top: 10.dp, left: 20.dp, right: 20.dp),
            child: BorderButton(width: double.infinity, height: 36.dp,
              text: entry.value.option,
              textStyle: TextStyles.textMain16,
              color: Colours.transparent,
              borderColor: Colours.app_main,
              onPressed: () {
                _eventModel.startOption(entry.value);
              },
            ),
          );
        }).toList() ?? [],
      ),
    );
  }

  void _eat() {
    Player? player = PlayerMgr.instance()!.getPlayer();
    _eventModel.startAction(Action(
        id: Action.action_eat,
        desc: [S.of(context).eatSth(player?.carried_prop?.name ?? '', player?.carried_prop?.desc ?? '')]
    ), burnEnergy: false);
  }

  void _discard() {
    Player? player = PlayerMgr.instance()!.getPlayer();
    _eventModel.startAction(Action(
        id: Action.action_discard,
        desc: _eventModel.isHomeState ?
        [S.of(context).putbackSth(player?.carried_prop?.name ?? '')] :
        [S.of(context).discardSth(player?.carried_prop?.name ?? '')]
    ), burnEnergy: false);
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
                _buildActionButton(ActionMgr.instance()!.getAction(Action.action_practice)),
                _buildActionButton(ActionMgr.instance()!.getAction(Action.action_goout)),
                _buildActionButton(ActionMgr.instance()!.getAction(Action.action_warehouse)),
                _buildActionButton(ActionMgr.instance()!.getAction(Action.action_rest)),
              ],
            ),
          );

          Widget practicePanel = ScaleWidget(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(ActionMgr.instance()!.getAction(Action.action_back)),
                _buildActionButton(ActionMgr.instance()!.getAction(Action.action_power)),
                _buildActionButton(ActionMgr.instance()!.getAction(Action.action_physic)),
                _buildActionButton(ActionMgr.instance()!.getAction(Action.action_skill)),
              ],
            ),
          );

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.dp, vertical: 5.dp),
                child: CarryPanel(
                  dark: false,
                  onEat: _eat,
                  onDiscard: _discard,
                ),
              ),
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    (!_eventModel.isFightState && !_eventModel.isMeetState) ? ScaleWidget(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.dp, vertical: 20.dp),
                          child: Column(
                            children: [
                              Expanded(child: Column(children: _buildTyper(_eventModel.getActionStr()))),
                              _eventModel.isHomeState ? actionPanel : Gaps.empty,
                              _eventModel.isPracticeState ? practicePanel : Gaps.empty,
                              _eventModel.isOutsideState ? OutsidePanel() : Gaps.empty,
                              _eventModel.isOptionState ? _buildOptionButtons() : Gaps.empty,
                              _eventModel.isPropOptionState ? PropOptionPanel() : Gaps.empty,
                            ],
                          ),
                        )
                    ) : Gaps.empty,

                    _eventModel.isFightState ? ScaleWidget(
                      child: FightPanel(
                        enemy: _eventModel.enemy!,
                        onFinish: (result) {
                          _eventModel.panelState = _eventModel.lastState;
                          _eventModel.fightResult = result;
                          if (ObjectUtil.isEmpty(result.props)) {
                            _eventModel.startAction(ActionMgr.instance()!.getAction(Action.action_fight_finish), burnEnergy: false);
                          } else {
                            _eventModel.startAction(ActionMgr.instance()!.getAction(Action.action_fight_finish), burnEnergy: false);
                            _eventModel.optionProp = result.props![0];
                            _eventModel.panelState = PanelState.propOption;
                          }
                        },
                      ),
                    ) : Gaps.empty,

                    _eventModel.isMeetState ? ScaleWidget(
                      child: MeetPanel(
                        npc: _eventModel.npc!,
                        onFinish: () {
                          _eventModel.panelState = _eventModel.lastState;
                        },
                      ),
                    ) : Gaps.empty
                  ],
                ),
              ),
            ],
          );
        });
  }
}
