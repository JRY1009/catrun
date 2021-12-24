import 'package:catrun/game/event/location_event.dart';
import 'package:catrun/game/model/property_diff.dart';
import 'package:catrun/utils/object_util.dart';

class Action {
  static const num action_practice = 1;
  static const num action_back = 100;
  static const num action_power = 101;
  static const num action_physic = 102;
  static const num action_skill = 103;

  static const num action_goout = 2;
  static const num action_fight_finish = 200;
  static const num action_outside_gohome = 201;
  static const num action_outside_garden = 202;
  static const num action_outside_recycle = 203;
  static const num action_outside_shop = 204;
  static const num action_outside_market = 205;
  static const num action_outside_station = 206;
  static const num action_outside_hospital = 207;
  static const num action_outside_stroll = 208;

  static const num action_garden_stroll = 2000;
  static const num action_recycle_stroll = 2001;
  static const num action_shop_stroll = 2002;
  static const num action_market_stroll = 2003;
  static const num action_station_stroll = 2004;
  static const num action_hospital_stroll = 2005;

  static const num action_garden_npc = 2020;
  static const num action_recycle_npc = 2021;
  static const num action_shop_npc = 2022;
  static const num action_market_npc = 2023;
  static const num action_station_npc = 2024;
  static const num action_hospital_npc = 2025;

  static const num action_warehouse = 3;
  static const num action_eat = 300;
  static const num action_discard = 301;

  static const num action_rest = 4;
  static const num action_rest_need = 400;
  static const num action_gohome_need = 401;
  static const num action_goout_banned = 402;

  static const num action_option = 5;
  static const num action_option_eat = 500;
  static const num action_option_discard = 501;
  static const num action_option_carry = 502;

  static bool isOutsideAction(num id) {
    return id >= action_outside_garden && id <= action_outside_stroll;
  }

  static bool isOutsideSubAction(num id) {
    return id >= action_garden_stroll && id <= action_hospital_stroll;
  }

  static bool isOutsideNpcAction(num id) {
    return id >= action_garden_npc && id <= action_hospital_npc;
  }

  static OutsideLocation switch2Location(num id) {
    OutsideLocation outside = OutsideLocation.unknown;
    switch (id) {
      case action_outside_garden:
      case action_garden_stroll:
        outside = OutsideLocation.garden;
        break;
      case action_outside_recycle:
      case action_recycle_stroll:
        outside = OutsideLocation.recycle;
        break;
      case action_outside_shop:
      case action_shop_stroll:
        outside = OutsideLocation.shop;
        break;
      case action_outside_market:
      case action_market_stroll:
        outside = OutsideLocation.market;
        break;
      case action_outside_station:
      case action_station_stroll:
        outside = OutsideLocation.station;
        break;
      case action_outside_hospital:
      case action_hospital_stroll:
        outside = OutsideLocation.hospital;
        break;
    }
    return outside;
  }

  static num switch2Action(OutsideLocation loc) {
    num id = 0;
    switch (loc) {
      case OutsideLocation.garden: id = action_outside_garden; break;
      case OutsideLocation.recycle: id = action_outside_recycle; break;
      case OutsideLocation.shop: id = action_outside_shop; break;
      case OutsideLocation.market: id = action_outside_market; break;
      case OutsideLocation.station: id = action_outside_station; break;
      case OutsideLocation.hospital: id = action_outside_hospital; break;
    }
    return id;
  }

  num? id;
  String? name;
  List<String>? desc;
  List<PropertyDiff>? diffs;

  Action({
    this.id,
    this.name,
    this.desc,
    this.diffs
  });

  Action.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'] ?? 0;
    name = jsonMap['name'] ?? '';
    desc = jsonMap['desc']?.cast<String>() ?? [''];
    if (ObjectUtil.isNotEmpty(jsonMap['diffs'])) {
      diffs = PropertyDiff.fromJsonList(jsonMap['diffs']) ?? [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonMap = {};
    jsonMap['id'] = id;
    jsonMap['name'] = name;
    jsonMap['desc'] = desc;
    jsonMap['diffs'] = diffs?.map((v) => v.toJson()).toList();

    return jsonMap;
  }

  static List<Action>? fromJsonList(List<dynamic> mapList) {
    if (ObjectUtil.isEmptyList(mapList)) {
      return null;
    }

    List<Action> items = [];
    for(Map<String, dynamic> map in mapList) {
      items.add(Action.fromJson(map));
    }
    return items;
  }
}