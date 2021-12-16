import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:catrun/game/config/app_config.dart';
import 'package:catrun/game/manager/fight_mgr.dart';
import 'package:catrun/game/model/enemy.dart';
import 'package:catrun/generated/l10n.dart';
import 'package:catrun/res/colors.dart';
import 'package:catrun/res/gaps.dart';
import 'package:catrun/res/styles.dart';
import 'package:catrun/utils/screen_util.dart';
import 'package:catrun/widget/animate/scale_text.dart';
import 'package:catrun/widget/animate/type_writer_text.dart';
import 'package:catrun/widget/button/border_button.dart';
import 'package:catrun/widget/shake/shake_animation_controller.dart';
import 'package:catrun/widget/shake/shake_animation_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FightPanel extends StatefulWidget {

  final Enemy enemy;
  final Function(Fight result) onFinish;

  FightPanel({
    Key? key,
    required this.enemy,
    required this.onFinish
  }): super(key: key);
  
  @override
  _FightPanelState createState() => _FightPanelState();
}

class _FightPanelState extends State<FightPanel> {

  int _round = 0;
  bool _reset = false;
  bool _enemyReset = false;
  bool _enableAction = true;

  late Fight _fight;
  late Fight _enemyFight;

  ShakeAnimationController _shakeAnimationController = new ShakeAnimationController();

  @override
  void initState() {
    super.initState();
    FightMgr.instance()!.setEnemy(widget.enemy);
    _fight = Fight(
      hert: 0,
      status: FightStatus.unknown,
      desc: '遇到${widget.enemy.name}\n${widget.enemy.speak}'
    );
    _enemyFight = Fight(
        hert: 0,
        status: FightStatus.unknown,
        desc: ''
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void startFight({enemy = false}) {
    setState(() {
      if (enemy) {
        _enemyReset = false;
      } else {
        _reset = false;
        _enemyReset = false;
      }
      Future.delayed(Duration(milliseconds: 100), () {
        setState(() {
          if (enemy) {
            _enemyReset = true;
          } else {
            _reset = true;
          }
        });
      });
    });
  }

  Widget _buildFight() {
    return Column(
      children: [
        Gaps.vGap10,
        _reset ? Container(
          alignment: Alignment.center,
          child: AnimatedTextKit(
            totalRepeatCount: 1,
            displayFullTextOnTap: true,
            pause: AppConfig.textPauseDuration,
            animatedTexts: [
              TypeWriterAnimatedText(_fight.desc, textStyle: TextStyles.textMain16_w700),
            ],
            onFinished: () {
              if (_fight.status == FightStatus.next ||
                  _fight.status == FightStatus.escape_failed) {
                Future.delayed(AppConfig.fightDuration, () {
                  _enemyFight = FightMgr.instance()!.enemyFight();
                  startFight(enemy: true);
                  _shakeAnimationController.start();
                });

              } else if (_fight.status == FightStatus.win) {
                Future.delayed(AppConfig.fightDuration, () {
                  if (widget.onFinish != null) {
                    widget.onFinish(
                        Fight(hert: 0,
                            status: FightStatus.lose,
                            desc: '你打败了${widget.enemy.name}')
                    );
                  }
                });
              } else if (_fight.status == FightStatus.escape) {

                Future.delayed(AppConfig.fightDuration, () {
                  if (widget.onFinish != null) {
                    widget.onFinish(
                        Fight(hert: 0,
                            status: FightStatus.escape,
                            desc: _fight.desc)
                    );
                  }
                });
              }
            },
          ),
        ) : Gaps.empty,
        Gaps.vGap10,
        _enemyReset ? Container(
          alignment: Alignment.center,
          child: AnimatedTextKit(
            totalRepeatCount: 1,
            displayFullTextOnTap: true,
            pause: AppConfig.textPauseDuration,
            animatedTexts: [
              ScaleInAnimatedText(_enemyFight.desc, textStyle: TextStyles.textMain16_w700),
            ],
            onFinished: () {
              _enableAction = true;
              if (_enemyFight.status == FightStatus.lose) {
                Future.delayed(AppConfig.fightDuration, () {
                  if (widget.onFinish != null) {
                    widget.onFinish(
                        Fight(hert: 0,
                            status: FightStatus.lose,
                            desc: '你被${widget.enemy.name}打败了')
                    );
                  }
                });
              }
            },
          ),
        ) : Gaps.empty,
      ],
    );
  }

  Widget _buildActionButton(String name, int action) {
    return BorderButton(width: 72.dp, height: 28.dp,
      text: name,
      textStyle: TextStyles.textMain12,
      color: Colours.transparent,
      borderColor: Colours.app_main,
      onPressed: () {
        if (!_enableAction) {
          return;
        }

        _enableAction = false;

        _round ++;
        if (action == 1) {
          _fight = FightMgr.instance()!.fight();
          startFight();

        } else if (action == 2) {
          _fight = FightMgr.instance()!.escape();
          startFight();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    Widget actionPanel = Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionButton(S.of(context).attack, 1),
          _buildActionButton(S.of(context).escape, 2),
        ],
      ),
    );

    return ShakeAnimationWidget(
      shakeAnimationController: _shakeAnimationController,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.dp, vertical: 20.dp),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(_round > 0 ? '${widget.enemy.name}\nhp：${widget.enemy.life}' :
              '${widget.enemy.name}\nhp：${widget.enemy.life}\n${widget.enemy.speak}',
                textAlign: TextAlign.center,
                style: TextStyles.textMain16_w700,
                strutStyle: StrutStyle(forceStrutHeight: true, height:1, leading: 0.5),
              )
            ),
            Expanded(child: _buildFight()),
            actionPanel
          ],
        ),
      ),
    );
  }

}
