
import 'dart:math';

import 'package:catrun/game/config/app_config.dart';
import 'package:catrun/game/event/event.dart';
import 'package:catrun/game/event/player_event.dart';
import 'package:catrun/game/event/time_event.dart';
import 'package:catrun/game/manager/player_mgr.dart';
import 'package:catrun/game/model/player.dart';

class TimeMgr {

  static TimeMgr? _instance;

  static TimeMgr? instance() {
    _instance ??= TimeMgr();
    return _instance;
  }

  int _day = 1;

  int getDay() => _day;

  reset() {
    _day = 1;
  }

  nextDay() {
    _day++;

    Player? player = PlayerMgr.instance()!.getPlayer();
    player?.energy = AppConfig.maxEnergy;
    player?.hungry = max((player.hungry ?? 0) - AppConfig.burnHungry, 0);
    player?.life = min((player.life ?? 0) + AppConfig.recoverLife, player.pmaxlife);

    Event.eventBus.fire(PlayerEvent(player, PlayerEventState.update));

    Event.eventBus.fire(TimeEvent(TimeEventState.update));
  }
}
