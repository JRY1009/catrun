import 'package:catrun/generated/l10n.dart';
import 'package:catrun/res/colors.dart';
import 'package:catrun/res/styles.dart';
import 'package:catrun/widget/button/border_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActionPanel extends StatefulWidget {
  @override
  _ActionPanelState createState() => _ActionPanelState();
}

class _ActionPanelState extends State<ActionPanel> {
  bool showSplash = true;
  int currentPosition = 0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BorderButton(
            width: 72,
            height: 28,
            text: '锻炼',
            textStyle: TextStyles.textMain12,
            color: Colours.transparent,
            borderColor: Colours.app_main,
            onPressed: () {

            },
          ),
          BorderButton(
            width: 72,
            height: 28,
            text: '外出',
            textStyle: TextStyles.textMain12,
            color: Colours.transparent,
            borderColor: Colours.app_main,
            onPressed: () {

            },
          ),
          BorderButton(
            width: 72,
            height: 28,
            text: '休息',
            textStyle: TextStyles.textMain12,
            color: Colours.transparent,
            borderColor: Colours.app_main,
            onPressed: () {

            },
          ),

        ],
      ),
    );
  }

}
