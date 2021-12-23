
import 'package:catrun/game/model/property_diff.dart';
import 'package:catrun/utils/object_util.dart';

class Prop {

  num? id;
  num? type;  //1消耗品 2非消耗品
  num? count;
  String? name;
  String? desc;
  List<PropertyDiff>? diffs;

  num getPropDiff(String property) {
    if (diffs == null) {
      return 0;
    }

    num diff = 0;
    int length = diffs!.length;
    for (int i=0; i<length; i++) {
      if (diffs![i].property == property) {
        diff = diff + (diffs![i].diff! * count!);
      }
    }

    return diff;
  }

  Prop({
    this.id,
    this.type,
    this.name,
    this.desc,
    this.count,
    this.diffs
  });

  Prop.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'] ?? 0;
    type = jsonMap['type'] ?? 1;
    count = jsonMap['count'] ?? 1;
    name = jsonMap['name'] ?? '';
    desc = jsonMap['desc'] ?? '';
    if (ObjectUtil.isNotEmpty(jsonMap['diffs'])) {
      diffs = PropertyDiff.fromJsonList(jsonMap['diffs']) ?? [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonMap = {};
    jsonMap['id'] = id;
    jsonMap['type'] = type;
    jsonMap['count'] = count;
    jsonMap['name'] = name;
    jsonMap['desc'] = desc;
    jsonMap['diffs'] = diffs?.map((v) => v.toJson()).toList();

    return jsonMap;
  }

  static List<Prop>? fromJsonList(List<dynamic> mapList) {
    if (ObjectUtil.isEmptyList(mapList)) {
      return null;
    }

    List<Prop> items = [];
    for(Map<String, dynamic> map in mapList) {
      items.add(Prop.fromJson(map));
    }
    return items;
  }
}