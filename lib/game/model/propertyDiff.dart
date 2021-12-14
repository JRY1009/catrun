import 'package:catrun/utils/object_util.dart';

class PropertyDiff {

  num? diff;
  String? property;

  PropertyDiff({
    this.diff,
    this.property,
  });

  PropertyDiff.fromJson(Map<String, dynamic> jsonMap) {
    diff = jsonMap['diff'] ?? 0;
    property = jsonMap['property'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonMap = new Map<String, dynamic>();
    jsonMap['diff'] = this.diff;
    jsonMap['property'] = this.property;

    return jsonMap;
  }

  static List<PropertyDiff>? fromJsonList(List<dynamic> mapList) {
    if (ObjectUtil.isEmptyList(mapList)) {
      return null;
    }

    List<PropertyDiff> items = [];
    for(Map<String, dynamic> map in mapList) {
      items.add(PropertyDiff.fromJson(map));
    }
    return items;
  }
}