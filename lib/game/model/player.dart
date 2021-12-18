
import 'package:catrun/game/model/prop.dart';
import 'package:catrun/game/model/property_diff.dart';
import 'package:catrun/generated/l10n.dart';

import 'role.dart';

class Player extends Role {

  num? hungry;
  num? energy;

  num get pmaxlife => ((maxlife ?? 0) + getPropDiff('maxlife'));
  num get pattack => ((attack ?? 0) + getPropDiff('attack'));
  num get pdefence => ((defence ?? 0) + getPropDiff('defence'));
  num get ppower => ((power ?? 0) + getPropDiff('power'));
  num get pphysic => ((physic ?? 0) + getPropDiff('physic'));
  num get pskill => ((skill ?? 0) + getPropDiff('skill'));
  num get pexplosion => ((explosion ?? 0) + getPropDiff('explosion'));
  num get pblock => ((block ?? 0) + getPropDiff('block'));
  num get pdodge => ((dodge ?? 0) + getPropDiff('dodge'));

  Player({
    this.hungry = 100,
    this.energy = 10
  }) : super(
      id: 1,
      name: S.current.yali,
      life: 100,
      maxlife: 100,
      attack: 50,
      defence: 10,
      power: 0,
      physic: 0,
      skill: 0,
      explosion: 0,
      block: 0,
      dodge: 0,
      props: []
  ) {

  }

  num getPropDiff(String property) {
    if (props == null) {
      return 0;
    }

    num diff = 0;
    int length = props!.length;
    for (int i=0; i<length; i++) {
      if (props![i].type == 2) {
        diff = diff + props![i].getPropDiff(property);
      }
    }

    return diff;
  }

  void addProps(List<Prop> propList) {
    if (props == null) {
      props = [];
    }

    int length = propList.length;
    for (int i=0; i<length; i++) {
      Prop? p = getProp(propList[i].id!);
      if (p == null) {
        props!.add(propList[i]);
      } else {
        p.count = (p.count ?? 0) + propList[i].count!;
      }
    }

    props!.sort((a, b) {
      num al = a.id!;
      num bl = b.id!;
      if (al > bl) return 1;
      else if (al < bl) return -1;
      return 0;
    });
  }

  Prop? getProp(num id) {
    if (props == null) {
      return null;
    }

    int length = props!.length;
    for (int i=0; i<length; i++) {
      if (props![i].id == id) {
        return props![i];
      }
    }

    return null;
  }

  void useProps(num id) {
    Prop? p = getProp(id);
    if (p == null) {
      return;
    }

    if (p.count! > 1) {
      p.count = p.count! - 1;
      makeDiffs(p.diffs ?? []);
    } else {
      makeDiffs(p.diffs ?? []);
      props?.remove(p);
    }
  }

  void makeDiff(PropertyDiff diff) {
    if (diff.property == 'hungry') {
      hungry = (hungry ?? 0) + (diff.diff ?? 0);
    } else if (diff.property == 'energy') {
      energy = (energy ?? 0) + (diff.diff ?? 0);
    } else if (diff.property == 'life') {
      life = (life ?? 0) + (diff.diff ?? 0);
    } else if (diff.property == 'maxlife') {
      maxlife = (maxlife ?? 0) + (diff.diff ?? 0);
    } else if (diff.property == 'attack') {
      attack = (attack ?? 0) + (diff.diff ?? 0);
    } else if (diff.property == 'defence') {
      defence = (defence ?? 0) + (diff.diff ?? 0);
    } else if (diff.property == 'power') {
      power = (power ?? 0) + (diff.diff ?? 0);
    } else if (diff.property == 'physic') {
      physic = (physic ?? 0) + (diff.diff ?? 0);
    } else if (diff.property == 'skill') {
      skill = (skill ?? 0) + (diff.diff ?? 0);
    } else if (diff.property == 'explosion') {
      explosion = (explosion ?? 0) + (diff.diff ?? 0);
    } else if (diff.property == 'block') {
      block = (block ?? 0) + (diff.diff ?? 0);
    } else if (diff.property == 'dodge') {
      dodge = (dodge ?? 0) + (diff.diff ?? 0);
    }
  }

  void makeDiffs(List<PropertyDiff> list) {
    for (int i=0; i<list.length; i++) {
      makeDiff(list[i]);
    }
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

