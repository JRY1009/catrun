
import 'dart:math';

import 'package:catrun/game/event/event.dart';
import 'package:catrun/game/event/player_event.dart';
import 'package:catrun/game/manager/player_mgr.dart';
import 'package:catrun/game/model/enemy.dart';
import 'package:catrun/game/model/player.dart';

enum FightStatus {
  win,
  lose,
  next,
  escape,
  escape_failed,
  unknown
}

class Fight {

  FightStatus status = FightStatus.unknown;
  num hert = 0;
  String desc = '';

  Fight({
    required this.status,
    required this.hert,
    required this.desc
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
    FightStatus status = FightStatus.unknown;
    num hert = 0;
    String desc = '';

    Player? player = PlayerMgr.instance()!.getPlayer();
    if (player != null && _enemy != null) {

      hert = max(player.attack! - _enemy!.defence!, 0);
      _enemy!.life = max(_enemy!.life! - hert, 0);

      desc = _enemy!.attackText!.replaceAll('{name}', '${_enemy?.name}').replaceAll('{hert}', '${hert}');
      if (_enemy!.life! <= 0) {
        status = FightStatus.win;
        desc = '${desc}，你打败了${_enemy?.name}';
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

  Fight enemyFight() {

    FightStatus status = FightStatus.unknown;
    num hert = 0;
    String desc = '';

    Player? player = PlayerMgr.instance()!.getPlayer();
    if (player != null && _enemy != null) {

      hert = max(_enemy!.attack! - player.defence!, 0);
      player.life = max(player.life! - hert, 0);

      desc = _enemy!.defenceText!.replaceAll('{name}', '${_enemy?.name}').replaceAll('{hert}', '${hert}');
      if (player.life! <= 0) {
        status = FightStatus.lose;
        desc = '${desc}，你被${_enemy?.name}打败了';
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
    FightStatus status = FightStatus.unknown;
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
