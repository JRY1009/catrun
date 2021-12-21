import 'package:catrun/utils/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'colors.dart';

class TextStyles {
  static const String familyRuizi = 'Ruizi';
  static const String familyBlackItalic = 'BlackItalic';

  static TextStyle textMain32_w700 = TextStyle(fontSize: 32.sp, color: Colours.app_main, fontWeight: FontWeight.w700, height: 1.0);
  static TextStyle textMain24_w700 = TextStyle(fontSize: 24.sp, color: Colours.app_main, fontWeight: FontWeight.w700, height: 1.0);
  static TextStyle textMain16 = TextStyle(fontSize: 16.sp, color: Colours.app_main, height: 1.0);
  static TextStyle textMain16_w700 = TextStyle(fontSize: 16.sp, color: Colours.app_main, fontWeight: FontWeight.w700, height: 1.0);
  static TextStyle textMain14 = TextStyle(fontSize: 14.sp, color: Colours.app_main, height: 1.0);
  static TextStyle textMain14_w700 = TextStyle(fontSize: 14.sp, color: Colours.app_main, fontWeight: FontWeight.w700, height: 1.0);
  static TextStyle textMain13 = TextStyle(fontSize: 13.sp, color: Colours.app_main, height: 1.0);
  static TextStyle textMain12 = TextStyle(fontSize: 12.sp, color: Colours.app_main, height: 1.0);
  static TextStyle textMain10 = TextStyle(fontSize: 10.sp, color: Colours.app_main, height: 1.0);

  static TextStyle textGray600_32_w700 = TextStyle(fontSize: 32.sp, color: Colours.gray_600, fontWeight: FontWeight.w700, height: 1.0);

  static TextStyle textWhite16 = TextStyle(fontSize: 16.sp, color: Colours.white, height: 1.0);
  static TextStyle textWhite16_w700 = TextStyle(fontSize: 16.sp, color: Colours.white, fontWeight: FontWeight.w700, height: 1.0);
  static TextStyle textWhite14 = TextStyle(fontSize: 14.sp, color: Colours.white, height: 1.0);
}

class BorderStyles {

  static OutlineInputBorder outlineInputR15Main = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.dp)),
      borderSide:  BorderSide(color: Colours.app_main)
  );

  static OutlineInputBorder outlineInputR15Gray = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.dp)),
      borderSide:  BorderSide(color: Colours.gray_100)
  );

  static OutlineInputBorder outlineInputR0White = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(0.0)),
      borderSide:  BorderSide(color: Colours.white)
  );

  static OutlineInputBorder outlineInputR0Gray100 = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(0.0)),
      borderSide:  BorderSide(color: Colours.gray_100)
  );

  static UnderlineInputBorder underlineInputMain = UnderlineInputBorder(
      borderSide:  BorderSide(color: Colours.app_main)
  );

  static UnderlineInputBorder underlineInputGray = UnderlineInputBorder(
      borderSide:  BorderSide(color: Colours.border_gray)
  );
}

class BoxShadows {

  static List<BoxShadow> normalBoxShadow = [
    BoxShadow(
      color: Colours.normal_border_shadow,
      offset: Offset(0.0, 1.dp),
      blurRadius: 10.dp,
      spreadRadius: 0.0,
    ),
  ];
}
