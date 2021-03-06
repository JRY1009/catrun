// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_CN locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh_CN';

  static String m0(param) => "你携带了 ${param}";

  static String m1(param) => "你来到了 ${param}";

  static String m2(param) => "你把 ${param} 丢掉了";

  static String m3(param, param2) => "你吃掉了 ${param}，${param2}";

  static String m4(param) => "你把 ${param} 放回了仓库";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appName": MessageLookupByLibrary.simpleMessage("小咪快跑"),
        "attack": MessageLookupByLibrary.simpleMessage("攻击"),
        "auto": MessageLookupByLibrary.simpleMessage("系统默认"),
        "back": MessageLookupByLibrary.simpleMessage("返回"),
        "block": MessageLookupByLibrary.simpleMessage("格挡"),
        "carry": MessageLookupByLibrary.simpleMessage("携带"),
        "carryProp": MessageLookupByLibrary.simpleMessage("携带物品"),
        "carryPropTips":
            MessageLookupByLibrary.simpleMessage("提示：携带新的物品时将自动丢掉旧的物品"),
        "carrySth": m0,
        "chinese": MessageLookupByLibrary.simpleMessage("简体中文"),
        "close": MessageLookupByLibrary.simpleMessage("关闭"),
        "come2Spl": m1,
        "confirm": MessageLookupByLibrary.simpleMessage("确定"),
        "defence": MessageLookupByLibrary.simpleMessage("防御"),
        "discard": MessageLookupByLibrary.simpleMessage("丢弃"),
        "discardSth": m2,
        "dodge": MessageLookupByLibrary.simpleMessage("闪避"),
        "doubleTapExit": MessageLookupByLibrary.simpleMessage("再按一次退出游戏"),
        "eat": MessageLookupByLibrary.simpleMessage("吃掉"),
        "eatSth": m3,
        "energy": MessageLookupByLibrary.simpleMessage("精神"),
        "english": MessageLookupByLibrary.simpleMessage("English"),
        "escape": MessageLookupByLibrary.simpleMessage("逃跑"),
        "explosion": MessageLookupByLibrary.simpleMessage("暴击"),
        "goOut": MessageLookupByLibrary.simpleMessage("外出"),
        "health": MessageLookupByLibrary.simpleMessage("健康"),
        "home": MessageLookupByLibrary.simpleMessage("家"),
        "hungry": MessageLookupByLibrary.simpleMessage("饱食度"),
        "language": MessageLookupByLibrary.simpleMessage("语言"),
        "life": MessageLookupByLibrary.simpleMessage("生命值"),
        "master": MessageLookupByLibrary.simpleMessage("大魔王"),
        "notFoundPage": MessageLookupByLibrary.simpleMessage("页面不存在"),
        "outside": MessageLookupByLibrary.simpleMessage("外出"),
        "physic": MessageLookupByLibrary.simpleMessage("体魄"),
        "power": MessageLookupByLibrary.simpleMessage("力量"),
        "practice": MessageLookupByLibrary.simpleMessage("锻炼"),
        "props": MessageLookupByLibrary.simpleMessage("物品"),
        "putback": MessageLookupByLibrary.simpleMessage("放回仓库"),
        "putbackSth": m4,
        "rest": MessageLookupByLibrary.simpleMessage("休息"),
        "skill": MessageLookupByLibrary.simpleMessage("灵巧"),
        "startGame": MessageLookupByLibrary.simpleMessage("开始游戏"),
        "use": MessageLookupByLibrary.simpleMessage("使用"),
        "yali": MessageLookupByLibrary.simpleMessage("Yali")
      };
}
