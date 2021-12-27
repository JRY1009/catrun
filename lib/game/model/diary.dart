
import 'package:catrun/utils/object_util.dart';

import 'option.dart';
import 'prop.dart';
import 'property_diff.dart';

class Diary {

  num? id;
  num? type;  //1确定事件，2选择事件，3战斗事件
  num? next_id; //下一幕故事
  num? enemy_id;
  List<String>? desc;
  List<PropertyDiff>? diffs;
  List<Option>? options;
  List<Prop>? props;

  Diary({
    this.id,
    this.type,
    this.enemy_id,
    this.desc,
    this.diffs,
  });

  Diary.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'] ?? 0;
    type = jsonMap['type'] ?? 1;
    enemy_id = jsonMap['enemy_id'] ?? 0;
    next_id = jsonMap['next_id'] ?? 2000;
    desc = jsonMap['desc']?.cast<String>() ?? [''];

    if (ObjectUtil.isNotEmpty(jsonMap['diffs'])) {
      diffs = PropertyDiff.fromJsonList(jsonMap['diffs']) ?? [];
    }

    if (ObjectUtil.isNotEmpty(jsonMap['options'])) {
      options = Option.fromJsonList(jsonMap['options']) ?? [];
    }

    if (ObjectUtil.isNotEmpty(jsonMap['props'])) {
      props = Prop.fromJsonList(jsonMap['props']) ?? [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonMap = {};
    jsonMap['id'] = id;
    jsonMap['type'] = type;
    jsonMap['next_id'] = next_id;
    jsonMap['enemy_id'] = enemy_id;
    jsonMap['desc'] = desc;
    jsonMap['diffs'] = diffs?.map((v) => v.toJson()).toList();
    jsonMap['options'] = options?.map((v) => v.toJson()).toList();
    jsonMap['props'] = props?.map((v) => v.toJson()).toList();


    return jsonMap;
  }

  static List<Diary>? fromJsonList(List<dynamic> mapList) {
    if (ObjectUtil.isEmptyList(mapList)) {
      return null;
    }

    List<Diary> items = [];
    for(Map<String, dynamic> map in mapList) {
      items.add(Diary.fromJson(map));
    }
    return items;
  }
}