import 'package:catrun/game/manager/player_mgr.dart';
import 'package:catrun/game/manager/time_mgr.dart';
import 'package:catrun/game/model/player.dart';
import 'package:catrun/game/viewmodel/player_model.dart';
import 'package:catrun/game/viewmodel/time_model.dart';
import 'package:catrun/generated/l10n.dart';
import 'package:catrun/mvvm/provider_widget.dart';
import 'package:catrun/res/styles.dart';
import 'package:catrun/utils/object_util.dart';
import 'package:catrun/utils/screen_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatusPanel extends StatefulWidget {
  @override
  _StatusPanelState createState() => _StatusPanelState();
}

class _StatusPanelState extends State<StatusPanel> {

  late PlayerModel _playerModel;
  late TimeModel _timeModel;

  @override
  void initState() {
    super.initState();

    _playerModel = PlayerModel();
    _playerModel.listenEvent();

    _timeModel = TimeModel();
    _timeModel.listenEvent();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildStatus(name, value) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 5.dp),
      padding: EdgeInsets.symmetric(horizontal: 5.dp, vertical: 3.dp),
      child: Text.rich(TextSpan(
          children: [
            TextSpan(text: '${name} ', style: TextStyles.textMain14),
            TextSpan(text: '${value}', style: TextStyles.textMain14),
          ]
      ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return ProviderWidget2<PlayerModel, TimeModel>(
        model1: _playerModel,
        model2: _timeModel,
        builder: (context, model1, model2, child) {

          int day = TimeMgr.instance()!.getDay();
          Player? player = PlayerMgr.instance()!.getPlayer();
          String location = _playerModel.getLocationStr();
          if (ObjectUtil.isNotEmpty(location)) {
            location = ' • ' + location;
          }

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.dp),
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.symmetric(vertical: 10.dp),
                    child: Text(
                        '第${day}天 • ${_playerModel.isHome ? S.of(context).home : S.of(context).outside}$location',
                        style: TextStyles.textMain16_w700
                    )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 2,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildStatus(S.of(context).energy, player?.energy),
                            _buildStatus(S.of(context).life, '${player?.life}/${player?.pmaxlife}'),
                            _buildStatus(S.of(context).hungry, player?.hungry),
                          ]
                      ),
                    ),
                    Expanded(flex: 2,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildStatus(S.of(context).health, player?.health),
                            _buildStatus(S.of(context).attack, player?.pattack),
                            _buildStatus(S.of(context).defence, player?.pdefence),
                          ]
                      ),
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildStatus(S.of(context).power, player?.ppower),
                          _buildStatus(S.of(context).physic, player?.pphysic),
                          _buildStatus(S.of(context).skill, player?.pskill),
                        ]
                    )
                  ],
                )
              ],
            ),
          );
        }
    );


  }

}
