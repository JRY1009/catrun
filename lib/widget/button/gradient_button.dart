import 'package:catrun/res/colors.dart';
import 'package:catrun/res/gaps.dart';
import 'package:catrun/res/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatefulWidget {

  final List<Color> colors;
  final String? text;
  final TextStyle? textStyle;
  final TextStyle? disableTextStyle;
  final double? width;
  final double? height;
  final Widget? icon;
  final double radius;
  final Function()? onPressed;

  GradientButton({
    Key? key,
    required this.colors,
    this.text,
    this.textStyle,
    this.disableTextStyle,
    this.width,
    this.height,
    this.icon,
    this.radius = 15,
    this.onPressed,
  }) : super(key: key);

  @override
  _GradientButtonState createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {

  @override
  Widget build(BuildContext context) {
    TextStyle disablStyle = widget.disableTextStyle ?? widget.textStyle ?? TextStyles.textWhite16;
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.radius),   //圆角
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: widget.colors,
        ),
      ),
      child: FlatButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(widget.radius))),
        disabledColor: Colours.button_disabled,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.icon ?? Gaps.empty,
            widget.icon == null ? Gaps.empty : Gaps.hGap5,
            Text(
              widget.text ?? '',
              style: widget.onPressed == null ? disablStyle : widget.textStyle,
            ),
          ],
        ),
        onPressed: widget.onPressed,
      ),
    );
  }
}
