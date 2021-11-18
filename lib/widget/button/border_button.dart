import 'package:catrun/res/colors.dart';
import 'package:catrun/res/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BorderButton extends StatefulWidget {

  final Color? color;
  final Color borderColor;
  final String? text;
  final TextStyle textStyle;
  final double? width;
  final double? height;
  final Function()? onPressed;

  BorderButton({
    Key? key,
    required this.borderColor,
    this.color,
    this.text,
    this.textStyle = TextStyles.textMain16,
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
        border: Border.all(color: widget.borderColor, width: 1.0),
        borderRadius: BorderRadius.circular(15.0),   //圆角
      ),
      child: FlatButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
        color: widget.color,
        disabledColor: Colours.button_disabled,
        child: Text(
          widget.text ?? '',
          style: widget.textStyle,
        ),
        onPressed: widget.onPressed,
      ),
    );
  }
}
