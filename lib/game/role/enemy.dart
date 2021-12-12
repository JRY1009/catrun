
import 'package:catrun/game/prop/prop.dart';
import 'package:catrun/generated/l10n.dart';

import 'Role.dart';

class Enemy extends Role {

  num? desc;

  Enemy({
    this.desc
  }) : super(
      id: '1',
      name: S.current.master,
      life: 50,
      attack: 5,
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

  Enemy.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'] ?? '';
    name = jsonMap['name'] ?? '';
    life = jsonMap['life'] ?? 0;
    attack = jsonMap['attack'] ?? 0;
    defence = jsonMap['defence'] ?? 0;
    power = jsonMap['power'] ?? 0;
    physic = jsonMap['physic'] ?? 0;
    skill = jsonMap['skill'] ?? 0;
    explosion = jsonMap['explosion'] ?? 0;
    block = jsonMap['block'] ?? 0;
    dodge = jsonMap['dodge'] ?? 0;
    props = Prop.fromJsonList(jsonMap['props']) ?? [];

  }

  Map<String, dynamic> toJson() {
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

    return jsonMap;
  }
}

