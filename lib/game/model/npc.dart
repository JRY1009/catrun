
import 'package:catrun/game/model/prop.dart';
import 'package:catrun/utils/object_util.dart';

import 'enemy.dart';
import 'meet.dart';
import 'property_diff.dart';

class Npc extends Enemy {

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
    this.meets,
  }) : super(
      speak: '',
      attackText: '',
      defenceText: '',
      winText: '',
      loseText: '',
      desc: []
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

    if (ObjectUtil.isNotEmpty(jsonMap['diffs'])) {
      diffs = PropertyDiff.fromJsonList(jsonMap['diffs']) ?? [];
    }

    desc = jsonMap['desc']?.cast<String>() ?? [''];

    speak = jsonMap['speak'] ?? '';
    attackText = jsonMap['attackText'] ?? '';
    defenceText = jsonMap['defenceText'] ?? '';
    winText = jsonMap['winText'] ?? '';
    loseText = jsonMap['loseText'] ?? '';

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
    jsonMap['diffs'] = diffs?.map((v) => v.toJson()).toList();
    jsonMap['desc'] = desc;

    jsonMap['speak'] = speak;
    jsonMap['attackText'] = attackText;
    jsonMap['defenceText'] = defenceText;
    jsonMap['winText'] = winText;
    jsonMap['loseText'] = loseText;

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

