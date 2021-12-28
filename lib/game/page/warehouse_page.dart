
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:catrun/game/config/app_config.dart';
import 'package:catrun/game/event/event.dart';
import 'package:catrun/game/event/player_event.dart';
import 'package:catrun/game/manager/player_mgr.dart';
import 'package:catrun/game/model/player.dart';
import 'package:catrun/game/viewmodel/player_model.dart';
import 'package:catrun/game/widget/carry_panel.dart';
import 'package:catrun/generated/l10n.dart';
import 'package:catrun/mvvm/provider_widget.dart';
import 'package:catrun/res/colors.dart';
import 'package:catrun/res/gaps.dart';
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

  int _count = 0;
  String tips = '';
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

  void startAction() {

    setState(() {
      _count = -1;

      Future.delayed(Duration(milliseconds: 100), () {
        setState(() {
          _count = 0;
        });
      });

    });
  }

  Widget _buildFade() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.dp),
      alignment: Alignment.center,
      child: AnimatedTextKit(
        totalRepeatCount: 1,
        displayFullTextOnTap: true,
        pause: AppConfig.textPauseDuration,
        animatedTexts: [
          FadeAnimatedText(tips,
              duration: const Duration(milliseconds: 1000),
              textStyle: TextStyles.textWhite16_w700),
        ],
        onFinished: () {
          setState(() {
            _count ++;
          });
        },
      ),
    );
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
                    padding: EdgeInsets.symmetric(horizontal: 10.dp, vertical: 10.dp),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          height: 30.dp,
                          child: _count >= 0 ? _buildFade() : Gaps.empty,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.dp),
                          child: CarryPanel(
                            dark: true,
                            onEat: () {
                              tips = player?.carried_prop?.desc ?? '';
                              startAction();
                            },
                          ),
                        ),
                        Expanded(
                          child: length <= 0 ? Center(
                            child: Text('啥也没有', style: TextStyles.textWhite16),
                          ) :
                          ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context, i) {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5.dp),
                                child: Row(
                                  children: [
                                    Text(player!.props![i].name!, style: TextStyles.textWhite14),
                                    Text('  x${player.props![i].count!}', style: TextStyles.textWhite14),
                                    Expanded(child: Container()),
                                    BorderButton(width: 72.dp, height: 28.dp,
                                      text: S.of(context).eat,
                                      textStyle: TextStyles.textWhite14,
                                      color: Colours.transparent,
                                      borderColor: Colours.white,
                                      onPressed: player.props![i].type == 1 ? () {
                                        tips = player.props![i].desc!;
                                        player.useProps(player.props![i].id!);

                                        startAction();
                                        Event.eventBus.fire(PlayerEvent(player, PlayerEventState.update));
                                      } : null,
                                    ),
                                    Gaps.hGap10,
                                    BorderButton(width: 72.dp, height: 28.dp,
                                      text: S.of(context).carry,
                                      textStyle: TextStyles.textWhite14,
                                      color: Colours.transparent,
                                      borderColor: Colours.white,
                                      onPressed: () {
                                        player.carryProp(player.props![i].id!);
                                        Event.eventBus.fire(PlayerEvent(player, PlayerEventState.update));
                                      },
                                    ),
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
