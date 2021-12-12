import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class TypeWriterAnimatedText extends AnimatedText {
  /// The [Duration] of the delay between the apparition of each characters
  ///
  /// By default it is set to 40 milliseconds.
  final Duration speed;

  /// The [Curve] of the rate of change of animation over time.
  ///
  /// By default it is set to Curves.linear.
  final Curve curve;

  TypeWriterAnimatedText(
      String text, {
        TextAlign textAlign = TextAlign.start,
        TextStyle? textStyle,
        this.speed = const Duration(milliseconds: 20),
        this.curve = Curves.linear,
      }) : super(
    text: text,
    textAlign: textAlign,
    textStyle: textStyle,
    duration: speed * text.characters.length,
  );

  late Animation<double> _typingText;

  @override
  Duration get remaining => speed * (textCharacters.length - _typingText.value);

  @override
  void initAnimation(AnimationController controller) {
    _typingText = CurveTween(
      curve: curve,
    ).animate(controller);
  }

  Widget completeText(BuildContext context) => Text(
    text,
    textAlign: textAlign,
    style: textStyle,
    strutStyle: StrutStyle(forceStrutHeight: true, height:1, leading: 0.5),
  );

  /// Widget showing partial text, up to [count] characters
  @override
  Widget animatedBuilder(BuildContext context, Widget? child) {
    /// Output of CurveTween is in the range [0, 1] for majority of the curves.
    /// It is converted to [0, textCharacters.length].
    final count =
    (_typingText.value.clamp(0, 1) * textCharacters.length).round();

    assert(count <= textCharacters.length);
    return Text(
      textCharacters.take(count).toString(),
      textAlign: textAlign,
      style: textStyle,
      strutStyle: StrutStyle(forceStrutHeight: true, height:1, leading: 0.5),
    );
  }
}