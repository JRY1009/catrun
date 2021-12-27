
import 'dart:convert';

import 'package:catrun/game/model/diary.dart';
import 'package:flutter/services.dart';

class DiaryMgr {

  static DiaryMgr? _instance;

  static DiaryMgr? instance() {
    _instance ??= DiaryMgr();
    return _instance;
  }

  List<Diary>? diaries;

  Future<List<Diary>?> loadDiaries() async{
    String jsonString = await rootBundle.loadString('assets/files/diaries.json');

    Map<String, dynamic> dataMap = json.decode(jsonString);

    diaries = Diary.fromJsonList(dataMap['diaries']);
  }

  Diary? getDiary(num id) {
    if (diaries == null) {
      return null;
    }

    int length = diaries!.length;
    for (int i=0; i<length; i++) {
      if (diaries![i].id == id) {
        Diary diary = Diary.fromJson(diaries![i].toJson());
        return diary;
      }
    }

    return null;
  }
}
