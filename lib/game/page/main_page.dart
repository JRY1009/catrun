import 'dart:async' as async;

import 'package:catrun/game/widget/action_panel.dart';
import 'package:catrun/game/widget/status_panel.dart';
import 'package:catrun/res/styles.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<MainPage> {
  bool showSplash = true;
  int currentPosition = 0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: Text('第一天', style: TextStyles.textMain16)
          ),
          StatusPanel(),
        ],
      ),
      bottomNavigationBar: ActionPanel(),
    );
  }

}
