import 'package:catrun/res/colors.dart';
import 'package:flutter/material.dart';

class BackButtonEx extends StatelessWidget {

  const BackButtonEx({
    Key? key,
    this.icon,
    this.onPressed
  }) : super(key: key);

  final Widget? icon;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    return IconButton(
      icon: icon ?? Icon(Icons.arrow_back_ios, color: Colours.app_main, size: 20),
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        } else {
          Navigator.maybePop(context);
        }
      },
    );
  }
}