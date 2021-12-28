import 'package:catrun/game/manager/player_mgr.dart';
import 'package:catrun/game/manager/prop_mgr.dart';
import 'package:catrun/game/model/action.dart';
import 'package:catrun/game/model/player.dart';
import 'package:catrun/game/model/prop.dart';
import 'package:catrun/game/viewmodel/event_model.dart';
import 'package:catrun/game/viewmodel/player_model.dart';
import 'package:catrun/generated/l10n.dart';
import 'package:catrun/res/colors.dart';
import 'package:catrun/res/gaps.dart';
import 'package:catrun/res/styles.dart';
import 'package:catrun/utils/screen_util.dart';
import 'package:catrun/widget/animate/scale_widget.dart';
import 'package:catrun/widget/button/border_button.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:provider/provider.dart';

class PropOptionPanel extends StatefulWidget {

  const PropOptionPanel({
    Key? key,
  }): super(key: key);

  @override
  _PropOptionPanelState createState() => _PropOptionPanelState();
}

class _PropOptionPanelState extends State<PropOptionPanel> {

  late PlayerModel _playerModel;

  @override
  void initState() {
    super.initState();

    _playerModel = PlayerModel();
    _playerModel.listenEvent();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    EventModel _eventModel  = Provider.of<EventModel>(context);

    return ScaleWidget(
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.only(top: 10.dp, left: 20.dp, right: 20.dp),
              alignment: Alignment.centerLeft,
              child: Text(S.of(context).carryPropTips, style: TextStyles.textMain12)
          ),
          Container(
            margin: EdgeInsets.only(top: 10.dp, left: 20.dp, right: 20.dp),
            child: BorderButton(width: double.infinity, height: 36.dp,
              text: S.of(context).carry,
              textStyle: TextStyles.textMain16,
              color: Colours.transparent,
              borderColor: Colours.app_main,
              onPressed: () {
                Player? player = PlayerMgr.instance()!.getPlayer();
                player?.carried_prop = PropMgr.instance()!.getProp(_eventModel.optionProp?.id ?? 0, 1);
                _eventModel.panelState = _eventModel.lastState;
                _eventModel.startAction(Action(
                    id: Action.action_option_carry,
                    desc: [S.of(context).carrySth(_eventModel.optionProp?.name ?? '')]
                ), burnEnergy: false);
              },
            ),
          ),
          _eventModel.optionProp?.type == 1 ? Container(
            margin: EdgeInsets.only(top: 10.dp, left: 20.dp, right: 20.dp),
            child: BorderButton(width: double.infinity, height: 36.dp,
              text: S.of(context).eat,
              textStyle: TextStyles.textMain16,
              color: Colours.transparent,
              borderColor: Colours.app_main,
              onPressed: () {
                Player? player = PlayerMgr.instance()!.getPlayer();
                Prop? prop = PropMgr.instance()!.getProp(_eventModel.optionProp?.id ?? 0, 1);
                player?.makeDiffs(prop?.diffs ?? []);
                _eventModel.panelState = _eventModel.lastState;
                _eventModel.startAction(Action(
                    id: Action.action_option_eat,
                    desc: [S.of(context).eatSth(_eventModel.optionProp?.name ?? '', _eventModel.optionProp?.desc ?? '')]
                ), burnEnergy: false);
              },
            ),
          ) : Gaps.empty,
          Container(
            margin: EdgeInsets.only(top: 10.dp, left: 20.dp, right: 20.dp),
            child: BorderButton(width: double.infinity, height: 36.dp,
              text: S.of(context).discard,
              textStyle: TextStyles.textMain16,
              color: Colours.transparent,
              borderColor: Colours.app_main,
              onPressed: () {
                _eventModel.panelState = _eventModel.lastState;
                _eventModel.startAction(Action(
                    id: Action.action_option_discard,
                    desc: [S.of(context).discardSth(_eventModel.optionProp?.name ?? '')]
                ), burnEnergy: false);
              },
            ),
          )
        ],
      ),
    );
  }

}
