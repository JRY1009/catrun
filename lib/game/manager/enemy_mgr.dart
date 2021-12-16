
import 'dart:convert';

import 'package:catrun/game/model/enemy.dart';
import 'package:flutter/services.dart';

class EnemyMgr {

  static EnemyMgr? _instance;

  static EnemyMgr? instance() {
    if (_instance == null) {
      _instance = new EnemyMgr();
    }
    return _instance;
  }

  List<Enemy>? enemies;

  Future<List<Enemy>?> loadEnemys() async{
    String jsonString = await rootBundle.loadString('assets/files/enemies.json');

    Map<String, dynamic> dataMap = json.decode(jsonString);

    enemies = Enemy.fromJsonList(dataMap['enemies']);
  }

  Enemy? getEnemy(num id) {
    if (enemies == null) {
      return null;
    }

    int length = enemies!.length;
    for (int i=0; i<length; i++) {
      if (enemies![i].id == id) {
        Enemy enemy = Enemy.fromJson(enemies![i].toJson());
        return enemy;
      }
    }

    return null;
  }
}
