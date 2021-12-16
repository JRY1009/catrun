
import 'package:catrun/utils/object_util.dart';

import 'option.dart';
import 'property_diff.dart';

class RandomEvent {

  static num event_type_property = 1;
  static num event_type_option = 2;
  static num event_type_fight = 3;

  num? id;
  num? type;  //1属性事件，2选择事件，3战斗事件
  String? name;
  num? enemy_id;
  List<String>? desc;
  List<PropertyDiff>? diffs;
  List<Option>? options;

  RandomEvent({
    this.id,
    this.type,
    this.name,
    this.enemy_id,
    this.desc,
    this.diffs,
  });

  RandomEvent.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'] ?? 0;
    type = jsonMap['type'] ?? 1;
    name = jsonMap['name'] ?? '';
    enemy_id = jsonMap['enemy_id'] ?? 2000;
    desc = jsonMap['desc']?.cast<String>() ?? [];

    if (ObjectUtil.isNotEmpty(jsonMap['diffs'])) {
      diffs = PropertyDiff.fromJsonList(jsonMap['diffs']) ?? [];
    }

    if (ObjectUtil.isNotEmpty(jsonMap['options'])) {
      options = Option.fromJsonList(jsonMap['options']) ?? [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonMap = new Map<String, dynamic>();
    jsonMap['id'] = this.id;
    jsonMap['type'] = this.type;
    jsonMap['name'] = this.name;
    jsonMap['enemy_id'] = this.enemy_id;
    jsonMap['desc'] = this.desc;
    jsonMap['diffs'] = this.diffs?.map((v) => v.toJson()).toList();
    jsonMap['options'] = this.options?.map((v) => v.toJson()).toList();

    return jsonMap;
  }

  static List<RandomEvent>? fromJsonList(List<dynamic> mapList) {
    if (ObjectUtil.isEmptyList(mapList)) {
      return null;
    }

    List<RandomEvent> items = [];
    for(Map<String, dynamic> map in mapList) {
      items.add(RandomEvent.fromJson(map));
    }
    return items;
  }
}