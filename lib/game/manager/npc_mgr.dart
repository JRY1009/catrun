
import 'dart:convert';

import 'package:catrun/game/model/npc.dart';
import 'package:flutter/services.dart';

class NpcMgr {

  static NpcMgr? _instance;

  static NpcMgr? instance() {
    _instance ??= NpcMgr();
    return _instance;
  }

  List<Npc>? npcs;
  Npc? xuedinge;

  Future loadNpcs() async{
    npcs ??= [];

    String jsonString = await rootBundle.loadString('assets/files/xuedinge.json');

    Map<String, dynamic> dataMap = json.decode(jsonString);

    xuedinge = Npc.fromJson(dataMap['xuedinge']);

    npcs!.add(xuedinge!);
  }

  Npc? getNpc(num id) {

    int length = npcs!.length;
    for (int i=0; i<length; i++) {
      if (npcs![i].id == id) {
        return npcs![i];
      }
    }

    return null;
  }
}
