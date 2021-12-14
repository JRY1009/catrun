import 'package:catrun/game/manager/player_mgr.dart';
import 'package:catrun/game/manager/time_mgr.dart';
import 'package:catrun/game/role/player.dart';
import 'package:catrun/game/viewmodel/player_model.dart';
import 'package:catrun/game/viewmodel/time_model.dart';
import 'package:catrun/mvvm/provider_widget.dart';
import 'package:catrun/res/styles.dart';
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
    _playerModel.listenEvent(context);

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

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.dp),
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.symmetric(vertical: 10.dp),
                    child: Text('第${day}天', style: TextStyles.textMain16_w700)
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildStatus('精神', player?.energy),
                          _buildStatus('生命', '${player?.life}/${player?.maxlife}'),
                          _buildStatus('饱食', player?.hungry),
                        ]
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildStatus('', ''),
                          _buildStatus('攻击', player?.attack),
                          _buildStatus('防御', player?.defence),
                        ]
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildStatus('力量', player?.power),
                          _buildStatus('体魄', player?.physic),
                          _buildStatus('灵巧', player?.skill),
                        ]
                    )
                  ],
                ),
              ],
            ),
          );
        }
    );


  }

}
