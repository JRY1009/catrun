// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `小咪快跑`
  String get appName {
    return Intl.message(
      '小咪快跑',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `关闭`
  String get close {
    return Intl.message(
      '关闭',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `语言`
  String get language {
    return Intl.message(
      '语言',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `简体中文`
  String get chinese {
    return Intl.message(
      '简体中文',
      name: 'chinese',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `系统默认`
  String get auto {
    return Intl.message(
      '系统默认',
      name: 'auto',
      desc: '',
      args: [],
    );
  }

  /// `页面不存在`
  String get notFoundPage {
    return Intl.message(
      '页面不存在',
      name: 'notFoundPage',
      desc: '',
      args: [],
    );
  }

  /// `开始游戏`
  String get startGame {
    return Intl.message(
      '开始游戏',
      name: 'startGame',
      desc: '',
      args: [],
    );
  }

  /// `确定`
  String get confirm {
    return Intl.message(
      '确定',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Yali`
  String get yali {
    return Intl.message(
      'Yali',
      name: 'yali',
      desc: '',
      args: [],
    );
  }

  /// `大魔王`
  String get master {
    return Intl.message(
      '大魔王',
      name: 'master',
      desc: '',
      args: [],
    );
  }

  /// `再按一次退出游戏`
  String get doubleTapExit {
    return Intl.message(
      '再按一次退出游戏',
      name: 'doubleTapExit',
      desc: '',
      args: [],
    );
  }

  /// `返回`
  String get back {
    return Intl.message(
      '返回',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `锻炼`
  String get practice {
    return Intl.message(
      '锻炼',
      name: 'practice',
      desc: '',
      args: [],
    );
  }

  /// `外出`
  String get goOut {
    return Intl.message(
      '外出',
      name: 'goOut',
      desc: '',
      args: [],
    );
  }

  /// `休息`
  String get rest {
    return Intl.message(
      '休息',
      name: 'rest',
      desc: '',
      args: [],
    );
  }

  /// `生命值`
  String get life {
    return Intl.message(
      '生命值',
      name: 'life',
      desc: '',
      args: [],
    );
  }

  /// `饱食度`
  String get hungry {
    return Intl.message(
      '饱食度',
      name: 'hungry',
      desc: '',
      args: [],
    );
  }

  /// `精神`
  String get energy {
    return Intl.message(
      '精神',
      name: 'energy',
      desc: '',
      args: [],
    );
  }

  /// `健康`
  String get health {
    return Intl.message(
      '健康',
      name: 'health',
      desc: '',
      args: [],
    );
  }

  /// `攻击`
  String get attack {
    return Intl.message(
      '攻击',
      name: 'attack',
      desc: '',
      args: [],
    );
  }

  /// `防御`
  String get defence {
    return Intl.message(
      '防御',
      name: 'defence',
      desc: '',
      args: [],
    );
  }

  /// `力量`
  String get power {
    return Intl.message(
      '力量',
      name: 'power',
      desc: '',
      args: [],
    );
  }

  /// `体魄`
  String get physic {
    return Intl.message(
      '体魄',
      name: 'physic',
      desc: '',
      args: [],
    );
  }

  /// `灵巧`
  String get skill {
    return Intl.message(
      '灵巧',
      name: 'skill',
      desc: '',
      args: [],
    );
  }

  /// `暴击`
  String get explosion {
    return Intl.message(
      '暴击',
      name: 'explosion',
      desc: '',
      args: [],
    );
  }

  /// `格挡`
  String get block {
    return Intl.message(
      '格挡',
      name: 'block',
      desc: '',
      args: [],
    );
  }

  /// `闪避`
  String get dodge {
    return Intl.message(
      '闪避',
      name: 'dodge',
      desc: '',
      args: [],
    );
  }

  /// `物品`
  String get props {
    return Intl.message(
      '物品',
      name: 'props',
      desc: '',
      args: [],
    );
  }

  /// `逃跑`
  String get escape {
    return Intl.message(
      '逃跑',
      name: 'escape',
      desc: '',
      args: [],
    );
  }

  /// `使用`
  String get use {
    return Intl.message(
      '使用',
      name: 'use',
      desc: '',
      args: [],
    );
  }

  /// `吃掉`
  String get eat {
    return Intl.message(
      '吃掉',
      name: 'eat',
      desc: '',
      args: [],
    );
  }

  /// `丢弃`
  String get discard {
    return Intl.message(
      '丢弃',
      name: 'discard',
      desc: '',
      args: [],
    );
  }

  /// `放回仓库`
  String get putback {
    return Intl.message(
      '放回仓库',
      name: 'putback',
      desc: '',
      args: [],
    );
  }

  /// `携带`
  String get carry {
    return Intl.message(
      '携带',
      name: 'carry',
      desc: '',
      args: [],
    );
  }

  /// `携带物品`
  String get carryProp {
    return Intl.message(
      '携带物品',
      name: 'carryProp',
      desc: '',
      args: [],
    );
  }

  /// `提示：携带新的物品时将自动丢掉旧的物品`
  String get carryPropTips {
    return Intl.message(
      '提示：携带新的物品时将自动丢掉旧的物品',
      name: 'carryPropTips',
      desc: '',
      args: [],
    );
  }

  /// `你携带了 {param}`
  String carrySth(Object param) {
    return Intl.message(
      '你携带了 $param',
      name: 'carrySth',
      desc: '',
      args: [param],
    );
  }

  /// `你吃掉了 {param}，{param2}`
  String eatSth(Object param, Object param2) {
    return Intl.message(
      '你吃掉了 $param，$param2',
      name: 'eatSth',
      desc: '',
      args: [param, param2],
    );
  }

  /// `你把 {param} 丢掉了`
  String discardSth(Object param) {
    return Intl.message(
      '你把 $param 丢掉了',
      name: 'discardSth',
      desc: '',
      args: [param],
    );
  }

  /// `你把 {param} 放回了仓库`
  String putbackSth(Object param) {
    return Intl.message(
      '你把 $param 放回了仓库',
      name: 'putbackSth',
      desc: '',
      args: [param],
    );
  }

  /// `家`
  String get home {
    return Intl.message(
      '家',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `外出`
  String get outside {
    return Intl.message(
      '外出',
      name: 'outside',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
