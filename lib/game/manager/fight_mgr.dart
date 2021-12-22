
import 'dart:math';

import 'package:catrun/game/event/event.dart';
import 'package:catrun/game/event/player_event.dart';
import 'package:catrun/game/manager/player_mgr.dart';
import 'package:catrun/game/manager/prop_mgr.dart';
import 'package:catrun/game/model/enemy.dart';
import 'package:catrun/game/model/player.dart';
import 'package:catrun/game/model/prop.dart';

enum FightStatus {
  win,
  lose,
  next,
  escape,
  escape_failed,
  normal
}

class Fight {

  FightStatus status = FightStatus.normal;
  num hert = 0;
  String desc = '';
  List<Prop>? props;

  Fight({
    required this.status,
    required this.hert,
    required this.desc,
    this.props
  });
}

class FightMgr {

  static FightMgr? _instance;

  static FightMgr? instance() {
    if (_instance == null) {
      _instance = new FightMgr();
    }
    return _instance;
  }

  Enemy? _enemy;

  Enemy? getEnemy() => _enemy;

  Random _random = Random();

  setEnemy(Enemy? enemy) {
    _enemy = enemy;
  }

  Fight fight() {
    FightStatus status = FightStatus.normal;
    num hert = 0;
    String desc = '';
    List<Prop>? props;

    Player? player = PlayerMgr.instance()!.getPlayer();
    if (player != null && _enemy != null) {

      hert = max(player.pattack - _enemy!.defence!, 0);
      _enemy!.life = max(_enemy!.life! - hert, 0);

      desc = _enemy!.attackText!.replaceAll('{name}', '${_enemy?.name}').replaceAll('{hert}', '${hert}');
      if (_enemy!.life! <= 0) {
        status = FightStatus.win;

        String winText = _enemy!.winText!.replaceAll('{name}', '${_enemy?.name}');
        desc = '${desc}，${winText}';

        props = PropMgr.instance()!.getProps(_enemy?.props) ?? [];
        //player.addProps(PropMgr.instance()!.getProps(_enemy?.props) ?? []);
        player.makeDiffs(_enemy?.diffs ?? []);

      } else {
        status = FightStatus.next;
        desc = '${desc}';
      }

      Event.eventBus.fire(PlayerEvent(player, PlayerEventState.update));
    }

    return Fight(
      hert: hert,
      status: status,
      desc: desc,
      props: props
    );
  }

  Fight enemyFight() {

    FightStatus status = FightStatus.normal;
    num hert = 0;
    String desc = '';

    Player? player = PlayerMgr.instance()!.getPlayer();
    if (player != null && _enemy != null) {

      hert = max(_enemy!.attack! - player.pdefence, 0);
      player.life = max(player.life! - hert, 0);

      desc = _enemy!.defenceText!.replaceAll('{name}', '${_enemy?.name}').replaceAll('{hert}', '${hert}');
      if (player.life! <= 0) {
        status = FightStatus.lose;

        String loseText = _enemy!.loseText!.replaceAll('{name}', '${_enemy?.name}');
        desc = '${desc}，${loseText}';
        player.life = 1;

      } else {
        status = FightStatus.next;
        desc = '${desc}';
      }

      Event.eventBus.fire(PlayerEvent(player, PlayerEventState.update));
    }

    return Fight(
        hert: hert,
        status: status,
        desc: desc
    );
  }

  Fight escape() {
    FightStatus status = FightStatus.normal;
    num hert = 0;
    String desc = '';

    Player? player = PlayerMgr.instance()!.getPlayer();
    if (player != null && _enemy != null) {

      bool ret = _random.nextBool();
      if (ret) {
        status = FightStatus.escape;
        desc = '逃跑成功';
      } else {
        status = FightStatus.escape_failed;
        desc = '逃跑失败';
      }

      Event.eventBus.fire(PlayerEvent(player, PlayerEventState.update));
    }

    return Fight(
        hert: hert,
        status: status,
        desc: desc
    );
  }
}
