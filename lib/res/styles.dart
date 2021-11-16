import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'colors.dart';

class TextStyles {
  static const String familyRuizi = 'Ruizi';
  static const String familyBlackItalic = 'BlackItalic';

  static const TextStyle textMain16 = TextStyle(fontSize: 16.0, color: Colours.app_main, height: 1.0);
  static const TextStyle textMain16_w700 = TextStyle(fontSize: 16.0, color: Colours.app_main, fontWeight: FontWeight.w700, height: 1.0);
  static const TextStyle textMain14 = TextStyle(fontSize: 14.0, color: Colours.app_main, height: 1.0);
  static const TextStyle textMain14_w700 = TextStyle(fontSize: 14.0, color: Colours.app_main, fontWeight: FontWeight.w700, height: 1.0);
  static const TextStyle textMain13 = TextStyle(fontSize: 13.0, color: Colours.app_main, height: 1.0);
  static const TextStyle textMain12 = TextStyle(fontSize: 12.0, color: Colours.app_main, height: 1.0);
  static const TextStyle textMain10 = TextStyle(fontSize: 10.0, color: Colours.app_main, height: 1.0);
}

class BorderStyles {

  static const OutlineInputBorder outlineInputR15Main = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
      borderSide:  BorderSide(color: Colours.app_main)
  );

  static const OutlineInputBorder outlineInputR15Gray = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
      borderSide:  BorderSide(color: Colours.gray_100)
  );

  static const OutlineInputBorder outlineInputR0White = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(0.0)),
      borderSide:  BorderSide(color: Colours.white)
  );

  static const OutlineInputBorder outlineInputR0Gray100 = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(0.0)),
      borderSide:  BorderSide(color: Colours.gray_100)
  );

  static const UnderlineInputBorder underlineInputMain = UnderlineInputBorder(
      borderSide:  BorderSide(color: Colours.app_main)
  );

  static const UnderlineInputBorder underlineInputGray = UnderlineInputBorder(
      borderSide:  BorderSide(color: Colours.border_gray)
  );
}

class BoxShadows {

  static const List<BoxShadow> normalBoxShadow = [
    BoxShadow(
      color: Colours.normal_border_shadow,
      offset: Offset(0.0, 1.0),
      blurRadius: 10.0,
      spreadRadius: 0.0,
    ),
  ];
}
