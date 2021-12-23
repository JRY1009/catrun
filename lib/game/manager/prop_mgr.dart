
import 'dart:convert';

import 'package:catrun/game/model/prop.dart';
import 'package:flutter/services.dart';

class PropMgr {

  static PropMgr? _instance;

  static PropMgr? instance() {
    _instance ??= PropMgr();
    return _instance;
  }

  List<Prop>? props;

  Future<List<Prop>?> loadProps() async{
    String jsonString = await rootBundle.loadString('assets/files/props.json');

    Map<String, dynamic> dataMap = json.decode(jsonString);

    props = Prop.fromJsonList(dataMap['props']);
  }

  Prop? getProp(num id, num count) {
    if (props == null) {
      return null;
    }

    int length = props!.length;
    for (int i=0; i<length; i++) {
      if (props![i].id == id) {
        Prop p = Prop.fromJson(props![i].toJson());
        p.count = count;
        return p;
      }
    }

    return null;
  }


  List<Prop>? getProps(List<Prop>? propList) {
    if (propList == null) {
      return null;
    }

    List<Prop> list = [];
    int length = propList.length;
    for (int i=0; i<length; i++) {
      Prop? p = getProp(propList[i].id!, propList[i].count!);
      if (p != null) {
        list.add(p);
      }
    }

    return list;
  }
}
