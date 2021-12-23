
import 'dart:convert';
import 'dart:math';

import 'package:catrun/game/model/revent.dart';
import 'package:flutter/services.dart';

class REventMgr {

  static REventMgr? _instance;

  static REventMgr? instance() {
    _instance ??= REventMgr();
    return _instance;
  }

  List<REvent>? events;
  List<REvent>? optionEvents;

  final Random _random = Random();

  Future<List<REvent>?> loadREvents() async{
    String jsonString = await rootBundle.loadString('assets/files/revents.json');

    Map<String, dynamic> dataMap = json.decode(jsonString);

    events = REvent.fromJsonList(dataMap['revents']);
    optionEvents = REvent.fromJsonList(dataMap['option_events']);
  }

  REvent? getRandomEvent() {
    if (events == null) {
      return null;
    }

    int length = events!.length;
    int r = _random.nextInt(length);

    REvent event = REvent.fromJson(events![r].toJson());
    return event;
  }

  REvent? getRandomEventById(num id) {
    if (events == null) {
      return null;
    }

    int length = events!.length;
    for (int i=0; i<length; i++) {
      if (events![i].id == id) {
        REvent event = REvent.fromJson(events![i].toJson());
        return event;
      }
    }

    return null;
  }

  REvent? getOptionEventById(num id) {
    if (optionEvents == null) {
      return null;
    }

    int length = optionEvents!.length;
    for (int i=0; i<length; i++) {
      if (optionEvents![i].id == id) {
        REvent event = REvent.fromJson(optionEvents![i].toJson());
        return event;
      }
    }

    return null;
  }
}
