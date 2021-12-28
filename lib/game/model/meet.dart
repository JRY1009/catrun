
import 'package:catrun/utils/object_util.dart';

import 'talk.dart';

class Meet {

  num? id;
  num? next_id;
  List<Talk>? talks;

  Talk? getTalkById(num id) {
    if (talks == null) {
      return null;
    }

    int length = talks!.length;
    for (int i=0; i<length; i++) {
      if (talks![i].id == id) {
        return talks![i];
      }
    }

    return null;
  }

  Meet({
    this.id,
    this.next_id,
    this.talks,
  });

  Meet.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'] ?? 0;
    next_id = jsonMap['next_id'] ?? 0;

    if (ObjectUtil.isNotEmpty(jsonMap['talks'])) {
      talks = Talk.fromJsonList(jsonMap['talks']) ?? [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonMap = {};
    jsonMap['id'] = id;
    jsonMap['next_id'] = next_id;
    jsonMap['talk_options'] = talks?.map((v) => v.toJson()).toList();

    return jsonMap;
  }

  static List<Meet>? fromJsonList(List<dynamic> mapList) {
    if (ObjectUtil.isEmptyList(mapList)) {
      return null;
    }

    List<Meet> items = [];
    for(Map<String, dynamic> map in mapList) {
      items.add(Meet.fromJson(map));
    }
    return items;
  }
}
