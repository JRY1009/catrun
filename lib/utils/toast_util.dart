import 'package:catrun/res/colors.dart';
import 'package:catrun/utils/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

const DEFAULT_TOAST_DURATION = Duration(milliseconds: 2500);

class ToastUtil {
  ToastUtil._internal();

  ///全局初始化Toast配置, child为MaterialApp
  static init(Widget child) {
    return OKToast(
      ///字体大小
      textStyle: TextStyle(fontSize: 15.sp, color: Colors.white),
      backgroundColor: Colours.toast_bg,
      radius: 3.dp,
      dismissOtherOnShow: true,
      textPadding: EdgeInsets.fromLTRB(20.dp, 10.dp, 20.dp, 10.dp),
      child: child,
      duration: DEFAULT_TOAST_DURATION,
    );
  }

  static void waring(String msg, {Duration duration = DEFAULT_TOAST_DURATION, ToastPosition position = ToastPosition.center}) {
    Widget widget = Container(
        margin: EdgeInsets.all(50.dp),
        decoration: BoxDecoration(
          color: Colours.toast_warn,
          borderRadius: BorderRadius.circular(3.dp),
        ),
        padding: EdgeInsets.fromLTRB(15.dp, 10.dp, 15.dp, 10.dp),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.warning, color: Colours.white, size: 25.dp),
              ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: ScreenUtil.instance().screenWidth - 160.dp),
                  child: Padding(
                      padding: EdgeInsets.only(left: 5.dp, top: 3.dp),
                      child: Text(msg,
                          strutStyle: StrutStyle(forceStrutHeight: true, height:1, leading: 0.5),
                          style: TextStyle(fontSize: 15.sp, color: Colours.white))
                  ))
            ]
        )
    );

    showToastWidget(
        widget,
        duration: duration,
        position: position
    );
  }

  static void error(String msg, {Duration duration = DEFAULT_TOAST_DURATION, ToastPosition position = ToastPosition.center}) {
    Widget widget = Container(
        margin: EdgeInsets.all(50.dp),
        decoration: BoxDecoration(
          color: Colours.toast_error,
          borderRadius: BorderRadius.circular(3.dp),
        ),
        padding: EdgeInsets.fromLTRB(15.dp, 10.dp, 15.dp, 10.dp),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.error, color: Colours.white, size: 25.dp),
              ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: ScreenUtil.instance().screenWidth - 160.dp),
                  child: Padding(
                      padding: EdgeInsets.only(left: 5.dp, top: 3.dp),
                      child: Text(msg,
                          strutStyle: StrutStyle(forceStrutHeight: true, height:1, leading: 0.5),
                          style: TextStyle(fontSize: 15.sp, color: Colours.white))
                  ))
            ]
        )
    );

    showToastWidget(
        widget,
        duration: duration,
        position: position
    );
  }

  static void success(String msg, {Duration duration = DEFAULT_TOAST_DURATION, ToastPosition position = ToastPosition.center}) {
    Widget widget = Container(
        margin: EdgeInsets.all(50.dp),
        decoration: BoxDecoration(
          color: Colours.toast_success,
          borderRadius: BorderRadius.circular(3.dp),
        ),
        padding: EdgeInsets.fromLTRB(15.dp, 10.dp, 15.dp, 10.dp),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.check, color: Colours.white, size: 25.dp),
              ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: ScreenUtil.instance().screenWidth - 160.dp),
                  child: Padding(
                      padding: EdgeInsets.only(left: 5.dp, top: 3.dp),
                      child: Text(msg,
                          strutStyle: StrutStyle(forceStrutHeight: true, height:1, leading: 0.5),
                          style: TextStyle(fontSize: 15.sp, color: Colours.white))
                  ))
            ]
        )
    );

    showToastWidget(
        widget,
        duration: duration,
        position: position
    );
  }

  static void normal(String msg, {Duration duration = DEFAULT_TOAST_DURATION, ToastPosition position = ToastPosition.center}) {

    Widget widget = Container(
      margin: EdgeInsets.all(50.dp),
      decoration: BoxDecoration(
        color: Colours.white,
        borderRadius: BorderRadius.circular(5.dp),
        boxShadow: [
          BoxShadow(
            color: Colours.toast_shadow_dark,
            offset: Offset(0.0, 0.0),
            blurRadius: 0.0,
            spreadRadius: 1.dp,
          ),
          BoxShadow(
            color: Colours.toast_shadow_light,
            offset: Offset(0.0, 2.dp),
            blurRadius: 4.dp,
            spreadRadius: 0.0,
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(15.dp, 10.dp, 15.dp, 10.dp),
      child: ClipRect(
        child: Text(
          msg,
          strutStyle: StrutStyle(forceStrutHeight: true, height:1, leading: 0.5),
          style: TextStyle(fontSize: 15.sp, color: Colours.black),
        ),
      ),
    );

    showToastWidget(
        widget,
        duration: duration,
        position: position
    );
  }

  static void cancelToast() {
    dismissAllToast();
  }
}
