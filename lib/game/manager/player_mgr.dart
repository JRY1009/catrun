
import 'dart:convert';

import 'package:catrun/game/event/event.dart';
import 'package:catrun/game/event/location_event.dart';
import 'package:catrun/game/model/player.dart';
import 'package:catrun/utils/object_util.dart';
import 'package:catrun/utils/sp_util.dart';

class PlayerMgr {

  static PlayerMgr? _instance;

  static PlayerMgr? instance() {
    _instance ??= PlayerMgr();
    return _instance;
  }


  Player? _player;

  Player? getPlayer() => _player;

  void setPlayer(Player? player) {
    _player = player;
  }

  LocationState _location = LocationState.home;
  LocationState getLocationState() => _location;
  void setLocationState(LocationState location) {
    _location = location;
    if (_location == LocationState.home) {
      _outside = OutsideLocation.unknown;
    }
    Event.eventBus.fire(LocationEvent(_location, outside: _outside));
  }

  OutsideLocation _outside = OutsideLocation.unknown;
  OutsideLocation getOutsideLocation() => _outside;
  void setOutsideLocation(OutsideLocation outside) {
    _outside = outside;
    Event.eventBus.fire(LocationEvent(LocationState.outside, outside: _outside));
  }

  savePlayer() async {
    await SPUtil.putString(
        SPUtil.key_player,
        json.encode(_player?.toLocalJson()));
  }

  Player? loadPlayer() {
    String jsonString = SPUtil.getString(SPUtil.key_player, defValue: '');

    if (ObjectUtil.isEmptyString(jsonString)) {
      return null;
    }

    Map<String, dynamic> jsonMap = json.decode(jsonString);
    return Player.fromLocalJson(jsonMap);
  }
}
