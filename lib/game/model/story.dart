import 'package:catrun/utils/object_util.dart';

class Story {

  String? id;
  String? name;

  Story({
    this.id,
    this.name,
  });

  Story.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'] ?? '';
    name = jsonMap['name'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonMap = new Map<String, dynamic>();
    jsonMap['id'] = this.id;
    jsonMap['name'] = this.name;

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