import 'package:catrun/game/model/property_diff.dart';
import 'package:catrun/utils/object_util.dart';

class Action {
  static num id_act_practice = 1;
  static num id_act_back = 100;
  static num id_act_power = 101;
  static num id_act_physic = 102;
  static num id_act_skill = 103;

  static num id_act_goout = 2;
  static num id_act_fight_finish = 200;
  static num id_act_outside_gohome = 201;
  static num id_act_outside_stroll = 202;
  static num id_act_outside_recycle = 203;
  static num id_act_outside_711 = 204;
  static num id_act_outside_market = 205;
  static num id_act_outside_station = 206;
  static num id_act_outside_hospital = 207;

  static num id_act_warehouse = 3;
  static num id_act_eat = 300;
  static num id_act_discard = 301;
  static num id_act_carry = 302;

  static num id_act_rest = 4;
  static num id_act_rest_need = 400;
  static num id_act_gohome_need = 401;
  static num id_act_goout_banned = 402;

  static num id_act_option = 5;

  num? id;
  String? name;
  List<String>? desc;
  List<PropertyDiff>? diffs;

  Action({
    this.id,
    this.name,
    this.desc,
    this.diffs
  });

  Action.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'] ?? 0;
    name = jsonMap['name'] ?? '';
    desc = jsonMap['desc']?.cast<String>() ?? [''];
    if (ObjectUtil.isNotEmpty(jsonMap['diffs'])) {
      diffs = PropertyDiff.fromJsonList(jsonMap['diffs']) ?? [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonMap = {};
    jsonMap['id'] = id;
    jsonMap['name'] = name;
    jsonMap['desc'] = desc;
    jsonMap['diffs'] = diffs?.map((v) => v.toJson()).toList();

    return jsonMap;
  }

  static List<Action>? fromJsonList(List<dynamic> mapList) {
    if (ObjectUtil.isEmptyList(mapList)) {
      return null;
    }

    List<Action> items = [];
    for(Map<String, dynamic> map in mapList) {
      items.add(Action.fromJson(map));
    }
    return items;
  }
}