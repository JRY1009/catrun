
import 'package:catrun/utils/object_util.dart';

import 'option.dart';
import 'prop.dart';
import 'property_diff.dart';

class Story {

  num? id;
  num? type;  //1确定事件，2选择事件，3战斗事件
  num? next_id; //下一幕故事
  num? enemy_id;
  List<String>? desc;
  List<PropertyDiff>? diffs;
  List<Option>? options;
  List<Prop>? props;

  Story({
    this.id,
    this.type,
    this.enemy_id,
    this.desc,
    this.diffs,
  });

  Story.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'] ?? 0;
    type = jsonMap['type'] ?? 1;
    enemy_id = jsonMap['enemy_id'] ?? 0;
    next_id = jsonMap['next_id'] ?? 2000;
    desc = jsonMap['desc']?.cast<String>() ?? [];

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
    final Map<String, dynamic> jsonMap = new Map<String, dynamic>();
    jsonMap['id'] = this.id;
    jsonMap['type'] = this.type;
    jsonMap['next_id'] = this.next_id;
    jsonMap['enemy_id'] = this.enemy_id;
    jsonMap['desc'] = this.desc;
    jsonMap['diffs'] = this.diffs?.map((v) => v.toJson()).toList();
    jsonMap['options'] = this.options?.map((v) => v.toJson()).toList();
    jsonMap['props'] = this.props?.map((v) => v.toJson()).toList();


    return jsonMap;
  }

  static List<Story>? fromJsonList(List<dynamic> mapList) {
    if (ObjectUtil.isEmptyList(mapList)) {
      return null;
    }

    List<Story> items = [];
    for(Map<String, dynamic> map in mapList) {
      items.add(Story.fromJson(map));
    }
    return items;
  }
}