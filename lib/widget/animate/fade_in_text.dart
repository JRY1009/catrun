import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class FadeInAnimatedText extends AnimatedText {
  final double fadeInEnd;

  FadeInAnimatedText(
      String text, {
        TextAlign textAlign = TextAlign.start,
        TextStyle? textStyle,
        Duration duration = const Duration(milliseconds: 500),
        this.fadeInEnd = 0.5,
      }) : super(
        text: text,
        textAlign: textAlign,
        textStyle: textStyle,
        duration: duration,
      );

  late Animation<double> _fadeIn;

  @override
  void initAnimation(AnimationController controller) {
    _fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, fadeInEnd, curve: Curves.linear),
      ),
    );
  }

  Widget completeText(BuildContext context) => Text(
    text,
    textAlign: textAlign,
    style: textStyle,
    strutStyle: StrutStyle(forceStrutHeight: true, height:1, leading: 0.5),
  );

  @override
  Widget animatedBuilder(BuildContext context, Widget? child) {
    return Opacity(
      opacity: _fadeIn.value != 1.0 ? _fadeIn.value : 1,
      child: Text(
        text,
        textAlign: textAlign,
        style: textStyle,
        strutStyle: StrutStyle(forceStrutHeight: true, height:1, leading: 0.5),
      ),
    );
  }
}