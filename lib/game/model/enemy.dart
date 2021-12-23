
import 'package:catrun/game/model/prop.dart';
import 'package:catrun/game/model/property_diff.dart';
import 'package:catrun/utils/object_util.dart';

import 'role.dart';

class Enemy extends Role {

  String? speak;
  String? attackText;
  String? defenceText;
  String? winText;
  String? loseText;
  List<String>? desc;
  List<PropertyDiff>? diffs;

  Enemy({
    this.speak,
    this.attackText,
    this.defenceText,
    this.winText,
    this.loseText,
    this.desc
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

  Enemy.fromJson(Map<String, dynamic> jsonMap) {
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

    return jsonMap;
  }
  
  static List<Enemy>? fromJsonList(List<dynamic> mapList) {
    if (ObjectUtil.isEmptyList(mapList)) {
      return null;
    }

    List<Enemy> items = [];
    for(Map<String, dynamic> map in mapList) {
      items.add(Enemy.fromJson(map));
    }
    return items;
  }
}

