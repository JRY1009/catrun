import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:catrun/game/manager/fight_mgr.dart';
import 'package:catrun/game/role/enemy.dart';
import 'package:catrun/res/colors.dart';
import 'package:catrun/res/gaps.dart';
import 'package:catrun/res/styles.dart';
import 'package:catrun/utils/screen_util.dart';
import 'package:catrun/widget/button/border_button.dart';
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

  Duration _duration = Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    FightMgr.instance()!.setEnemy(widget.enemy);
    _fight = Fight(
      hert: 0,
      status: FightStatus.unknown,
      desc: '遇到${widget.enemy.name}'
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
        _reset ? Container(
          alignment: Alignment.center,
          child: AnimatedTextKit(
            totalRepeatCount: 1,
            displayFullTextOnTap: true,
            animatedTexts: [
              TyperAnimatedText(_fight.desc, textStyle: TextStyles.textMain16_w700),
            ],
            onFinished: () {
              if (_fight.status == FightStatus.next) {
                Future.delayed(_duration, () {
                  _enemyFight = FightMgr.instance()!.enemyFight();
                  startFight(enemy: true);
                });

              } else if (_fight.status == FightStatus.win) {
                Future.delayed(_duration, () {
                  if (widget.onFinish != null) {
                    widget.onFinish(
                        Fight(hert: 0,
                            status: FightStatus.lose,
                            desc: '你打败了${widget.enemy.name}')
                    );
                  }
                });
              }
            },
          ),
        ) : Gaps.empty,
        _enemyReset ? Container(
          alignment: Alignment.center,
          child: AnimatedTextKit(
            totalRepeatCount: 1,
            displayFullTextOnTap: true,
            animatedTexts: [
              TyperAnimatedText(_enemyFight.desc, textStyle: TextStyles.textMain16_w700),
            ],
            onFinished: () {
              _enableAction = true;
              if (_enemyFight.status == FightStatus.lose) {
                Future.delayed(_duration, () {
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
        if (action == 1) {
          _fight = FightMgr.instance()!.fight();
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
          _buildActionButton('攻击', 1),
          _buildActionButton('逃跑', 2),
        ],
      ),
    );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.dp, vertical: 20.dp),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: Text('${widget.enemy.name}\nhp：${widget.enemy.life}', style: TextStyles.textMain16_w700),
          ),
          Expanded(child: _buildFight()),
          actionPanel
        ],
      ),
    );
  }

}
