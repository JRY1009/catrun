
import 'dart:convert';
import 'dart:math';

import 'package:catrun/game/model/random_event.dart';
import 'package:flutter/services.dart';

class RandomEventMgr {

  static RandomEventMgr? _instance;

  static RandomEventMgr? instance() {
    if (_instance == null) {
      _instance = new RandomEventMgr();
    }
    return _instance;
  }

  List<RandomEvent>? events;
  List<RandomEvent>? subEvents;

  Random _random = Random();

  Future<List<RandomEvent>?> loadRandomEvents() async{
    String jsonString = await rootBundle.loadString('assets/files/random_events.json');

    Map<String, dynamic> dataMap = json.decode(jsonString);

    events = RandomEvent.fromJsonList(dataMap['random_events']);
    subEvents = RandomEvent.fromJsonList(dataMap['sub_events']);
  }

  RandomEvent? getRandomEvent() {
    if (events == null) {
      return null;
    }

    int length = events!.length;
    int r = _random.nextInt(length);

    return events![r];
  }

  RandomEvent? getRandomEventById(num id) {
    if (events == null) {
      return null;
    }

    int length = events!.length;
    for (int i=0; i<length; i++) {
      if (events![i].id == id) {
        return events![i];
      }
    }

    return null;
  }

  RandomEvent? getSubEventById(num id) {
    if (subEvents == null) {
      return null;
    }

    int length = subEvents!.length;
    for (int i=0; i<length; i++) {
      if (subEvents![i].id == id) {
        return subEvents![i];
      }
    }

    return null;
  }
}
