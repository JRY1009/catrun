
import 'package:catrun/game/event/event.dart';
import 'package:catrun/game/event/player_event.dart';
import 'package:catrun/game/manager/player_mgr.dart';
import 'package:catrun/game/model/player.dart';
import 'package:catrun/game/viewmodel/player_model.dart';
import 'package:catrun/generated/l10n.dart';
import 'package:catrun/mvvm/provider_widget.dart';
import 'package:catrun/res/colors.dart';
import 'package:catrun/res/styles.dart';
import 'package:catrun/router/routers.dart';
import 'package:catrun/utils/screen_util.dart';
import 'package:catrun/widget/button/border_button.dart';
import 'package:flutter/material.dart';

class WareHousePage extends StatefulWidget {

  WareHousePage({
    Key? key,
  }): super(key: key);

  @override
  _WareHousePageState createState() => _WareHousePageState();
}

class _WareHousePageState extends State<WareHousePage> {

  late PlayerModel _playerModel;

  @override
  void initState() {
    super.initState();

    _playerModel = PlayerModel();
    _playerModel.listenEvent(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildBackButton() {
    return BorderButton(width: 108.dp, height: 36.dp,
        text: S.of(context).back,
        textStyle: TextStyles.textWhite16,
        color: Colours.transparent,
        borderColor: Colours.white,
        onPressed: () {
          Routers.goBack(context);
        },
      );
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
          backgroundColor: Colors.black,
          body: ProviderWidget<PlayerModel>(
              model: _playerModel,
              builder: (context, model, child) {
                Player? player = PlayerMgr.instance()!.getPlayer();
                int length = player?.props?.length ?? 0;
                return SafeArea(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.dp, vertical: 20.dp),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          child: length <= 0 ? Center(
                            child: Text('啥也没有', style: TextStyles.textWhite16),
                          ) :
                          ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context, i) {
                              return Container(
                                height: 30.dp,
                                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5.dp),
                                child: Row(
                                  children: [
                                    Text(player!.props![i].name!, style: TextStyles.textWhite14),
                                    Text('  x${player.props![i].count!}', style: TextStyles.textWhite14),
                                    Expanded(child: Container()),
                                    BorderButton(width: 84.dp, height: 28.dp,
                                      text: S.of(context).use,
                                      textStyle: TextStyles.textWhite14,
                                      color: Colours.transparent,
                                      borderColor: Colours.white,
                                      onPressed: player.props![i].type == 1 ? () {
                                        player.useProps(player.props![i].id!);
                                        Event.eventBus.fire(PlayerEvent(player, PlayerEventState.update));
                                      } : null,
                                    )
                                  ],
                                ),
                              );
                            },
                            itemCount: length,
                          ),
                        ),
                        _buildBackButton()
                      ],
                    ),
                  ),
                );
              }
          )
      ),
    );
  }

}
