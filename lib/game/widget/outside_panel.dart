import 'package:catrun/game/manager/action_mgr.dart';
import 'package:catrun/game/model/action.dart';
import 'package:catrun/game/viewmodel/event_model.dart';
import 'package:catrun/game/viewmodel/player_model.dart';
import 'package:catrun/mvvm/provider_widget.dart';
import 'package:catrun/res/colors.dart';
import 'package:catrun/res/gaps.dart';
import 'package:catrun/res/styles.dart';
import 'package:catrun/utils/screen_util.dart';
import 'package:catrun/widget/animate/scale_widget.dart';
import 'package:catrun/widget/button/border_button.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:provider/provider.dart';

class OutsidePanel extends StatefulWidget {

  const OutsidePanel({
    Key? key,
  }): super(key: key);

  @override
  _OutsidePanelState createState() => _OutsidePanelState();
}

class _OutsidePanelState extends State<OutsidePanel> {

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

  Widget _buildLocationRow(BuildContext context) {

    Widget widget = Gaps.empty;
    if (_playerModel.isGarden) {
      widget = Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildLocationButton(context, ActionMgr.instance()!.getAction(Action.action_garden_stroll)),
              _buildLocationButton(context, ActionMgr.instance()!.getAction(Action.action_garden_npc)),
              Container(width: 72.dp, height: 28.dp),
              Container(width: 72.dp, height: 28.dp),
            ],
          );
    } else if (_playerModel.isRecycle) {
      widget = Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildLocationButton(context, ActionMgr.instance()!.getAction(Action.action_recycle_stroll)),
          _buildLocationButton(context, ActionMgr.instance()!.getAction(Action.action_recycle_npc)),
          Container(width: 72.dp, height: 28.dp),
          Container(width: 72.dp, height: 28.dp),
        ],
      );
    } else if (_playerModel.isShop) {
      widget = Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildLocationButton(context, ActionMgr.instance()!.getAction(Action.action_shop_stroll)),
          _buildLocationButton(context, ActionMgr.instance()!.getAction(Action.action_shop_npc)),
          Container(width: 72.dp, height: 28.dp),
          Container(width: 72.dp, height: 28.dp),
        ],
      );
    } else if (_playerModel.isMarket) {
      widget = Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildLocationButton(context, ActionMgr.instance()!.getAction(Action.action_market_stroll)),
          _buildLocationButton(context, ActionMgr.instance()!.getAction(Action.action_market_npc)),
          Container(width: 72.dp, height: 28.dp),
          Container(width: 72.dp, height: 28.dp),
        ],
      );
    } else if (_playerModel.isStation) {
      widget = Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildLocationButton(context, ActionMgr.instance()!.getAction(Action.action_station_stroll)),
          _buildLocationButton(context, ActionMgr.instance()!.getAction(Action.action_station_npc)),
          Container(width: 72.dp, height: 28.dp),
          Container(width: 72.dp, height: 28.dp),
        ],
      );
    } else if (_playerModel.isHospital) {
      widget = Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildLocationButton(context, ActionMgr.instance()!.getAction(Action.action_hospital_stroll)),
          _buildLocationButton(context, ActionMgr.instance()!.getAction(Action.action_hospital_npc)),
          Container(width: 72.dp, height: 28.dp),
          Container(width: 72.dp, height: 28.dp),
        ],
      );
    }

    return widget;
  }

  Widget _buildLocationButton(BuildContext context, Action? action) {

    EventModel _eventModel  = Provider.of<EventModel>(context);

    return BorderButton(width: 72.dp, height: 28.dp,
        text: action?.name,
        textStyle: TextStyles.textDarkMain12,
        color: Colours.transparent,
        borderColor: Colours.dark_app_main,
        onPressed: () {
          _eventModel.doAction(context, action);
        }
    );
  }

  Widget _buildActionButton(BuildContext context, bool enable, Action? action) {

    EventModel _eventModel  = Provider.of<EventModel>(context);

    return BorderButton(width: 72.dp, height: 28.dp,
        text: action?.name,
        textStyle: TextStyles.textMain12,
        color: Colours.transparent,
        borderColor: Colours.app_main,
        onPressed: enable ? () {
          _eventModel.doAction(context, action);
        } : null
    );
  }

  @override
  Widget build(BuildContext context) {

    return ProviderWidget<PlayerModel>(
        model: _playerModel,
        builder: (context, model, child) {
          return ScaleWidget(
            child: Column(
              children: [
                _buildLocationRow(context),
                Gaps.vGap10,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildActionButton(context, true, ActionMgr.instance()!.getAction(Action.action_outside_gohome)),
                    _buildActionButton(context, !_playerModel.isGarden, ActionMgr.instance()!.getAction(Action.action_outside_garden)),
                    _buildActionButton(context, !_playerModel.isRecycle, ActionMgr.instance()!.getAction(Action.action_outside_recycle)),
                    _buildActionButton(context, !_playerModel.isShop, ActionMgr.instance()!.getAction(Action.action_outside_shop)),
                  ],
                ),
                Gaps.vGap10,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildActionButton(context, !_playerModel.isMarket, ActionMgr.instance()!.getAction(Action.action_outside_market)),
                    _buildActionButton(context, !_playerModel.isStation, ActionMgr.instance()!.getAction(Action.action_outside_station)),
                    _buildActionButton(context, !_playerModel.isHospital, ActionMgr.instance()!.getAction(Action.action_outside_hospital)),
                    Container(width: 72.dp, height: 28.dp),
                  ],
                ),
              ],
            ),
          );
        }
    );


  }

}
