import 'dart:async' as async;

import 'package:catrun/game/manager/player_mgr.dart';
import 'package:catrun/game/role/player.dart';
import 'package:catrun/game/widget/event_panel.dart';
import 'package:catrun/game/widget/status_panel.dart';
import 'package:catrun/res/gaps.dart';
import 'package:flutter/material.dart';

BuildContext? sMainContext;

class MainPage extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<MainPage> {

  @override
  void initState() {
    super.initState();
    sMainContext = context;
    PlayerMgr.instance()!.setPlayer(Player());
  }

  @override
  void dispose() {
    super.dispose();
    sMainContext = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Gaps.vGap20,
          StatusPanel(),
          Expanded(child: EventPanel())
        ],
      ),
    );
  }

}
