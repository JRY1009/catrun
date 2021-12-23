import 'package:catrun/game/event/event.dart';
import 'package:catrun/game/event/player_event.dart';
import 'package:catrun/game/manager/player_mgr.dart';
import 'package:catrun/game/model/player.dart';
import 'package:catrun/game/viewmodel/player_model.dart';
import 'package:catrun/generated/l10n.dart';
import 'package:catrun/mvvm/provider_widget.dart';
import 'package:catrun/res/colors.dart';
import 'package:catrun/res/gaps.dart';
import 'package:catrun/res/styles.dart';
import 'package:catrun/utils/screen_util.dart';
import 'package:catrun/widget/button/border_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarryPanel extends StatefulWidget {
  final bool dark;
  final Function()? onEat;
  final Function()? onDiscard;

  const CarryPanel({
    Key? key,
    this.dark = false,
    this.onEat,
    this.onDiscard
  }): super(key: key);
  
  @override
  _CarryPanelState createState() => _CarryPanelState();
}

class _CarryPanelState extends State<CarryPanel> {

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

    return ProviderWidget<PlayerModel>(
        model: _playerModel,
        builder: (context, model, child) {

          Player? player = PlayerMgr.instance()!.getPlayer();

          return Container(
                height: 40.dp,
                color: widget.dark ? Colours.transparent : Colours.gray_100,
                padding: EdgeInsets.symmetric(horizontal: 5.dp, vertical: 7.dp),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text('${S.of(context).carryProp}：', style: widget.dark ? TextStyles.textWhite14 : TextStyles.textMain14),
                    Text('${player?.carriedProp?.name ?? '暂无'}  ', style: widget.dark ? TextStyles.textWhite14 : TextStyles.textMain14),
                    Expanded(child: Container()),
                    player?.carriedProp?.type == 1 ? BorderButton(width: 64.dp, height: 24.dp, radius: 5.dp,
                      text: S.of(context).eat,
                      textStyle: widget.dark ? TextStyles.textWhite12 : TextStyles.textMain12,
                      color: Colours.transparent,
                      borderColor: widget.dark ? Colours.white : Colours.black,
                      onPressed: () {
                        if (widget.onEat != null) {
                          widget.onEat!();
                        }
                        player?.useCarriedProp();
                        Event.eventBus.fire(PlayerEvent(player, PlayerEventState.update));
                      },
                    ) : Gaps.empty,
                    Gaps.hGap10,
                    player?.carriedProp != null ? BorderButton(width: 64.dp, height: 24.dp, radius: 5.dp,
                      text: _playerModel.isHome ? S.of(context).putback : S.of(context).discard,
                      textStyle: widget.dark ? TextStyles.textWhite12 : TextStyles.textMain12,
                      color: Colours.transparent,
                      borderColor: widget.dark ? Colours.white : Colours.black,
                      onPressed: () {
                        if (widget.onDiscard != null) {
                          widget.onDiscard!();
                        }
                        player?.discardProp(discard: _playerModel.isOutSide);
                        Event.eventBus.fire(PlayerEvent(player, PlayerEventState.update));
                      },
                    ) : Gaps.empty,
                  ],
                )
            );
        }
    );


  }

}
