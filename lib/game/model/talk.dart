
import 'package:catrun/utils/object_util.dart';

class Talk {

  num? id;
  List<String>? talk;
  List<TalkOption>? talk_options;

  Talk({
    this.id,
    this.talk,
  });

  Talk.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'] ?? 0;
    talk = jsonMap['talk']?.cast<String>() ?? [''];

    if (ObjectUtil.isNotEmpty(jsonMap['talk_options'])) {
      talk_options = TalkOption.fromJsonList(jsonMap['talk_options']) ?? [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonMap = {};
    jsonMap['id'] = id;
    jsonMap['talk'] = talk;
    jsonMap['talk_options'] = talk_options?.map((v) => v.toJson()).toList();

    return jsonMap;
  }

  static List<Talk>? fromJsonList(List<dynamic> mapList) {
    if (ObjectUtil.isEmptyList(mapList)) {
      return null;
    }

    List<Talk> items = [];
    for(Map<String, dynamic> map in mapList) {
      items.add(Talk.fromJson(map));
    }
    return items;
  }
}


class TalkOption {

  num? next_id;
  num? none_id;
  num? next_meet_id;
  String? option;
  bool? check_require;

  TalkOption({
    this.next_id,
    this.next_meet_id,
    this.option,
  });

  TalkOption.fromJson(Map<String, dynamic> jsonMap) {
    next_id = jsonMap['next_id'] ?? 0;
    none_id = jsonMap['none_id'] ?? 0;
    next_meet_id = jsonMap['next_meet_id'] ?? 0;
    option = jsonMap['option'] ?? '';
    check_require = jsonMap['check_require'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonMap = {};
    jsonMap['next_id'] = next_id;
    jsonMap['none_id'] = none_id;
    jsonMap['next_meet_id'] = next_meet_id;
    jsonMap['option'] = option;
    jsonMap['check_require'] = check_require;

    return jsonMap;
  }

  static List<TalkOption>? fromJsonList(List<dynamic> mapList) {
    if (ObjectUtil.isEmptyList(mapList)) {
      return null;
    }

    List<TalkOption> items = [];
    for(Map<String, dynamic> map in mapList) {
      items.add(TalkOption.fromJson(map));
    }
    return items;
  }
}