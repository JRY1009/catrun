
import 'dart:math';

import 'package:catrun/game/event/event.dart';
import 'package:catrun/game/event/player_event.dart';
import 'package:catrun/game/event/time_event.dart';
import 'package:catrun/game/manager/player_mgr.dart';
import 'package:catrun/game/model/player.dart';

class TimeMgr {

  static TimeMgr? _instance;

  static TimeMgr? instance() {
    if (_instance == null) {
      _instance = new TimeMgr();
    }
    return _instance;
  }

  int _day = 1;

  int getDay() => _day;

  nextDay() {
    _day++;

    Player? player = PlayerMgr.instance()!.getPlayer();
    player?.energy = 10;
    player?.hungry = max((player.hungry ?? 0) - 20, 0);
    player?.life = min((player.life ?? 0) + 50, player.maxlife ?? 0);

    Event.eventBus.fire(PlayerEvent(player, PlayerEventState.update));

    Event.eventBus.fire(TimeEvent(TimeEventState.update));
  }
}
