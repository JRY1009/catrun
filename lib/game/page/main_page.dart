
import 'package:catrun/game/widget/event_panel.dart';
import 'package:catrun/game/widget/status_panel.dart';
import 'package:catrun/res/gaps.dart';
import 'package:catrun/widget/double_tap_back_exit_app.dart';
import 'package:flutter/material.dart';

BuildContext? sMainContext;

class MainPage extends StatefulWidget {

  const MainPage({
    Key? key,
  }): super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<MainPage> {

  @override
  void initState() {
    super.initState();
    sMainContext = context;
  }

  @override
  void dispose() {
    super.dispose();
    sMainContext = null;
  }

  @override
  Widget build(BuildContext context) {
    return DoubleTapBackExitApp(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Gaps.vGap20,
            StatusPanel(),
            Expanded(child: EventPanel())
          ],
        ),
      ),
    );
  }

}
