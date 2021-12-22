
import 'dart:convert';

import 'package:catrun/game/model/player.dart';
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
