
import 'dart:convert';

import 'package:catrun/game/model/player.dart';
import 'package:catrun/game/model/property_diff.dart';
import 'package:catrun/utils/object_util.dart';
import 'package:catrun/utils/sp_util.dart';

class PlayerMgr {

  static PlayerMgr? _instance;

  static PlayerMgr? instance() {
    if (_instance == null) {
      _instance = new PlayerMgr();
    }
    return _instance;
  }

  Player? _player;

  Player? getPlayer() => _player;

  void setPlayer(Player? player) {
    _player = player;
  }

  void makeDiff(PropertyDiff diff) {
    if (diff.property == 'hungry') {
      _player?.hungry = (_player?.hungry ?? 0) + (diff.diff ?? 0);
    } else if (diff.property == 'energy') {
      _player?.energy = (_player?.energy ?? 0) + (diff.diff ?? 0);
    } else if (diff.property == 'life') {
      _player?.life = (_player?.life ?? 0) + (diff.diff ?? 0);
    } else if (diff.property == 'maxlife') {
      _player?.maxlife = (_player?.maxlife ?? 0) + (diff.diff ?? 0);
    } else if (diff.property == 'attack') {
      _player?.attack = (_player?.attack ?? 0) + (diff.diff ?? 0);
    } else if (diff.property == 'defence') {
      _player?.defence = (_player?.defence ?? 0) + (diff.diff ?? 0);
    } else if (diff.property == 'power') {
      _player?.power = (_player?.power ?? 0) + (diff.diff ?? 0);
    } else if (diff.property == 'physic') {
      _player?.physic = (_player?.physic ?? 0) + (diff.diff ?? 0);
    } else if (diff.property == 'skill') {
      _player?.skill = (_player?.skill ?? 0) + (diff.diff ?? 0);
    } else if (diff.property == 'explosion') {
      _player?.explosion = (_player?.explosion ?? 0) + (diff.diff ?? 0);
    } else if (diff.property == 'block') {
      _player?.block = (_player?.block ?? 0) + (diff.diff ?? 0);
    } else if (diff.property == 'dodge') {
      _player?.dodge = (_player?.dodge ?? 0) + (diff.diff ?? 0);
    }
  }

  void makeDiffs(List<PropertyDiff> list) {
    for (int i=0; i<list.length; i++) {
      makeDiff(list[i]);
    }
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
    if (jsonMap == null) {
      return null;
    } else {
      return Player.fromLocalJson(jsonMap);
    }
  }
}
