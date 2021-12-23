
import 'dart:convert';

import 'package:catrun/game/model/story.dart';
import 'package:flutter/services.dart';

class StoryMgr {

  static StoryMgr? _instance;

  static StoryMgr? instance() {
    _instance ??= StoryMgr();
    return _instance;
  }

  List<Story>? stories;

  Future<List<Story>?> loadStorys() async{
    String jsonString = await rootBundle.loadString('assets/files/stories.json');

    Map<String, dynamic> dataMap = json.decode(jsonString);

    stories = Story.fromJsonList(dataMap['stories']);
  }

  Story? getStory(num id) {
    if (stories == null) {
      return null;
    }

    int length = stories!.length;
    for (int i=0; i<length; i++) {
      if (stories![i].id == id) {
        Story story = Story.fromJson(stories![i].toJson());
        return story;
      }
    }

    return null;
  }
}
