
import 'package:catrun/utils/object_util.dart';

class Prop {

  num? id;
  String? name;

  Prop({
    this.id,
    this.name,
  });

  Prop.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'] ?? 0;
    name = jsonMap['name'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonMap = new Map<String, dynamic>();
    jsonMap['id'] = this.id;
    jsonMap['name'] = this.name;

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