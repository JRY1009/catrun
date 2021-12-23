
import 'package:catrun/utils/object_util.dart';

class Option {

  num? id;
  String? option;

  Option({
    this.id,
    this.option,
  });

  Option.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'] ?? 0;
    option = jsonMap['option'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonMap = {};
    jsonMap['id'] = id;
    jsonMap['option'] = option;

    return jsonMap;
  }

  static List<Option>? fromJsonList(List<dynamic> mapList) {
    if (ObjectUtil.isEmptyList(mapList)) {
      return null;
    }

    List<Option> items = [];
    for(Map<String, dynamic> map in mapList) {
      items.add(Option.fromJson(map));
    }
    return items;
  }
}