
import 'package:catrun/game/event/event.dart';
import 'package:catrun/game/event/player_event.dart';
import 'package:catrun/game/manager/player_mgr.dart';
import 'package:catrun/game/model/property_diff.dart';
import 'package:catrun/utils/object_util.dart';

import 'player.dart';
import 'prop.dart';
import 'talk.dart';

class Meet {

  num? id;
  num? talk_id;
  List<Talk>? talks;

  Prop? prop_require;
  List<PropertyDiff>? property_require;

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

  bool checkRequire() {
    bool ret = true;

    Player? player = PlayerMgr.instance()!.getPlayer();
    if (prop_require != null) {
      if (player?.carried_prop?.id != prop_require!.id) {
        ret = false;
      } else {
        player?.discardProp(discard: true);
        Event.eventBus.fire(PlayerEvent(player, PlayerEventState.update));
      }
    }

    if (property_require != null) {
      int length = property_require!.length;
      for (int i=0; i<length; i++) {
        PropertyDiff diff = property_require![i];
        if (diff.property == 'hungry') {
          if ((player?.hungry ?? 0) < (diff.diff ?? 0)) { ret = false; }
        } else if (diff.property == 'energy') {
          if ((player?.energy ?? 0) < (diff.diff ?? 0)) { ret = false; }
        } else if (diff.property == 'life') {
          if ((player?.life ?? 0) < (diff.diff ?? 0)) { ret = false; }
        } else if (diff.property == 'maxlife') {
          if ((player?.maxlife ?? 0) < (diff.diff ?? 0)) { ret = false; }
        } else if (diff.property == 'attack') {
          if ((player?.attack ?? 0) < (diff.diff ?? 0)) { ret = false; }
        } else if (diff.property == 'defence') {
          if ((player?.defence ?? 0) < (diff.diff ?? 0)) { ret = false; }
        } else if (diff.property == 'power') {
          if ((player?.power ?? 0) < (diff.diff ?? 0)) { ret = false; }
        } else if (diff.property == 'physic') {
          if ((player?.physic ?? 0) < (diff.diff ?? 0)) { ret = false; }
        } else if (diff.property == 'skill') {
          if ((player?.skill ?? 0) < (diff.diff ?? 0)) { ret = false; }
        } else if (diff.property == 'explosion') {
          if ((player?.explosion ?? 0) < (diff.diff ?? 0)) { ret = false; }
        } else if (diff.property == 'block') {
          if ((player?.block ?? 0) < (diff.diff ?? 0)) { ret = false; }
        } else if (diff.property == 'dodge') {
          if ((player?.dodge ?? 0) < (diff.diff ?? 0)) { ret = false; }
        }
      }
    }
    return ret;
  }

  Meet({
    this.id,
    this.talk_id,
    this.talks,
  });

  Meet.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'] ?? 0;
    talk_id = jsonMap['talk_id'] ?? 0;

    if (ObjectUtil.isNotEmpty(jsonMap['talks'])) {
      talks = Talk.fromJsonList(jsonMap['talks']) ?? [];
    }

    if (ObjectUtil.isNotEmpty(jsonMap['prop_require'])) {
      prop_require = Prop.fromJson(jsonMap['prop_require']);
    }

    if (ObjectUtil.isNotEmpty(jsonMap['property_require'])) {
      property_require = PropertyDiff.fromJsonList(jsonMap['property_require']) ?? [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonMap = {};
    jsonMap['id'] = id;
    jsonMap['talk_id'] = talk_id;
    jsonMap['talk_options'] = talks?.map((v) => v.toJson()).toList();
    jsonMap['prop_require'] = prop_require?.toJson();
    jsonMap['property_require'] = property_require?.map((v) => v.toJson()).toList();

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
