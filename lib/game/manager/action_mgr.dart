
import 'dart:convert';

import 'package:catrun/game/model/action.dart';
import 'package:flutter/services.dart';

class ActionMgr {

  static ActionMgr? _instance;

  static ActionMgr? instance() {
    _instance ??= ActionMgr();
    return _instance;
  }

  List<Action>? actions;

  Future<List<Action>?> loadActions() async{
    String jsonString = await rootBundle.loadString('assets/files/actions.json');

    Map<String, dynamic> dataMap = json.decode(jsonString);

    actions = Action.fromJsonList(dataMap['actions']);
  }

  Action? getAction(num id) {
    if (actions == null) {
      return null;
    }

    int length = actions!.length;
    for (int i=0; i<length; i++) {
      if (actions![i].id == id) {
        return actions![i];
      }
    }

    return null;
  }
}
