
import 'package:catrun/game/model/prop.dart';
import 'package:catrun/generated/l10n.dart';

import 'Role.dart';

class Player extends Role {

  num? desc;
  num? hungry;
  num? energy;

  Player({
    this.desc,
    this.hungry = 100,
    this.energy = 10
  }) : super(
      id: 1,
      name: S.current.yali,
      life: 100,
      maxlife: 100,
      attack: 10,
      defence: 0,
      power: 0,
      physic: 0,
      skill: 0,
      explosion: 0,
      block: 0,
      dodge: 0,
      props: []
  ) {

  }

  Player.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'] ?? '';
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
    props = Prop.fromJsonList(jsonMap['props']) ?? [];

    hungry = jsonMap['hungry'] ?? 0;
    energy = jsonMap['energy'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonMap = new Map<String, dynamic>();
    jsonMap['id'] = this.id;
    jsonMap['name'] = this.name;
    jsonMap['life'] = this.life;
    jsonMap['maxlife'] = this.maxlife;
    jsonMap['attack'] = this.attack;
    jsonMap['defence'] = this.defence;
    jsonMap['power'] = this.power;
    jsonMap['physic'] = this.physic;
    jsonMap['skill'] = this.skill;
    jsonMap['explosion'] = this.explosion;
    jsonMap['block'] = this.block;
    jsonMap['dodge'] = this.dodge;
    jsonMap['props'] = this.props?.map((v) => v.toJson()).toList();

    jsonMap['hungry'] = this.hungry;
    jsonMap['energy'] = this.energy;
    return jsonMap;
  }

  Player.fromLocalJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'] ?? '';
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
    props = Prop.fromJsonList(jsonMap['props']) ?? [];

    hungry = jsonMap['hungry'] ?? 0;
    energy = jsonMap['energy'] ?? 0;
  }

  Map<String, dynamic> toLocalJson() {
    final Map<String, dynamic> jsonMap = new Map<String, dynamic>();
    jsonMap['id'] = this.id;
    jsonMap['name'] = this.name;
    jsonMap['life'] = this.life;
    jsonMap['attack'] = this.attack;
    jsonMap['defence'] = this.defence;
    jsonMap['power'] = this.power;
    jsonMap['physic'] = this.physic;
    jsonMap['skill'] = this.skill;
    jsonMap['explosion'] = this.explosion;
    jsonMap['block'] = this.block;
    jsonMap['dodge'] = this.dodge;
    jsonMap['props'] = this.props?.map((v) => v.toJson()).toList();

    jsonMap['hungry'] = this.hungry;
    jsonMap['energy'] = this.energy;
    return jsonMap;
  }

}

