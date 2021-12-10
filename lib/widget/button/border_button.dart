import 'package:catrun/res/colors.dart';
import 'package:catrun/res/styles.dart';
import 'package:catrun/utils/screen_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BorderButton extends StatefulWidget {

  final Color? color;
  final Color borderColor;
  final String? text;
  final TextStyle? textStyle;
  final double? width;
  final double? height;
  final Function()? onPressed;

  BorderButton({
    Key? key,
    required this.borderColor,
    this.color,
    this.text,
    this.textStyle,
    this.width,
    this.height,
    this.onPressed,
  }) : super(key: key);

  @override
  _BorderButtonState createState() => _BorderButtonState();
}

class _BorderButtonState extends State<BorderButton> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        border: Border.all(color: widget.borderColor, width: 1.dp),
        borderRadius: BorderRadius.circular(10.dp),   //圆角
      ),
      child: FlatButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.dp))),
        color: widget.color,
        disabledColor: Colours.button_disabled,
        child: Text(
          widget.text ?? '',
          style: widget.textStyle ?? TextStyles.textMain16,
        ),
        onPressed: widget.onPressed,
      ),
    );
  }
}
