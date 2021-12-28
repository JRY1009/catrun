
import 'package:catrun/game/model/prop.dart';
import 'package:catrun/utils/object_util.dart';

import 'meet.dart';
import 'role.dart';

class Npc extends Role {

  num? next_id;
  List<Meet>? meets;

  Meet? getMeetById(num id) {
    if (meets == null) {
      return null;
    }

    int length = meets!.length;
    for (int i=0; i<length; i++) {
      if (meets![i].id == id) {
        return meets![i];
      }
    }

    return null;
  }

  Npc({
    this.next_id,
    this.meets
  }) : super(
      id: 2000,
      name: '0',
      life: 50,
      maxlife: 50,
      attack: 20,
      defence: 0,
      power: 0,
      physic: 0,
      skill: 0,
      explosion: 0,
      block: 0,
      dodge: 0,
      props: []
  );

  Npc.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'] ?? 2000;
    name = jsonMap['name'] ?? '';
    life = jsonMap['life'] ?? 0;
    maxlife = jsonMap['maxlife'] ?? 0;
    attack = jsonMap['attack'] ?? 0;
    defence = jsonMap['defence'] ?? 0;
    power = jsonMap['power'] ?? 0;
    physic = jsonMap['physic'] ?? 0;
    skill = jsonMap['skill'] ?? 0;
    explosion = jsonMap['explosion'] ?? 0;
    block = jsonMap['block'] ?? 0;
    dodge = jsonMap['dodge'] ?? 0;

    if (ObjectUtil.isNotEmpty(jsonMap['props'])) {
      props = Prop.fromJsonList(jsonMap['props']) ?? [];
    }

    if (ObjectUtil.isNotEmpty(jsonMap['meets'])) {
      meets = Meet.fromJsonList(jsonMap['meets']) ?? [];
    }

    next_id = jsonMap['next_id'] ?? 0;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonMap = {};
    jsonMap['id'] = id;
    jsonMap['name'] = name;
    jsonMap['life'] = life;
    jsonMap['maxlife'] = maxlife;
    jsonMap['attack'] = attack;
    jsonMap['defence'] = defence;
    jsonMap['power'] = power;
    jsonMap['physic'] = physic;
    jsonMap['skill'] = skill;
    jsonMap['explosion'] = explosion;
    jsonMap['block'] = block;
    jsonMap['dodge'] = dodge;
    jsonMap['props'] = props?.map((v) => v.toJson()).toList();
    jsonMap['meets'] = meets?.map((v) => v.toJson()).toList();

    jsonMap['next_id'] = next_id;
    return jsonMap;
  }

  static List<Npc>? fromJsonList(List<dynamic> mapList) {
    if (ObjectUtil.isEmptyList(mapList)) {
      return null;
    }

    List<Npc> items = [];
    for(Map<String, dynamic> map in mapList) {
      items.add(Npc.fromJson(map));
    }
    return items;
  }
}

