
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:catrun/game/config/app_config.dart';
import 'package:catrun/game/manager/npc_mgr.dart';
import 'package:catrun/game/model/meet.dart';
import 'package:catrun/game/model/npc.dart';
import 'package:catrun/game/model/talk.dart';
import 'package:catrun/res/colors.dart';
import 'package:catrun/res/gaps.dart';
import 'package:catrun/res/styles.dart';
import 'package:catrun/utils/screen_util.dart';
import 'package:catrun/widget/animate/scale_widget.dart';
import 'package:catrun/widget/animate/type_writer_text.dart';
import 'package:catrun/widget/button/border_button.dart';
import 'package:flutter/material.dart';

class MeetPanel extends StatefulWidget {

  final Npc npc;
  final Function() onFinish;

  MeetPanel({
    Key? key,
    required this.npc,
    required this.onFinish
  }): super(key: key);

  @override
  _MeetPanelState createState() => _MeetPanelState();
}

class _MeetPanelState extends State<MeetPanel> {

  int _count = 0;

  Meet? _meet;
  Talk? _talk;

  @override
  void initState() {
    super.initState();

    _meet = widget.npc.getMeetById(widget.npc.next_id ?? 0);
    _talk = _meet?.getTalkById(_meet?.next_id ?? 0);

    startAction();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void startAction() {

    setState(() {
      _count = -1;

      Future.delayed(Duration(milliseconds: 100), () {
        setState(() {
          _count = 0;
        });
      });
    });
  }

  List<Widget> _buildFade(List<String> listStr) {
    return listStr.asMap().entries.map((entry) {
      return _count >= entry.key ? Container(
        padding: EdgeInsets.symmetric(vertical: 5.dp),
        alignment: Alignment.center,
        child: AnimatedTextKit(
          totalRepeatCount: 1,
          displayFullTextOnTap: true,
          pause: AppConfig.textPauseDuration,
          animatedTexts: [
            TypeWriterAnimatedText(entry.value, textAlign: TextAlign.center, textStyle: TextStyles.textMain16_w700),
          ],
          onFinished: () {
            setState(() {
              _count ++;
            });
          },
        ),
      ) : Gaps.empty;
    }).toList();
  }

  Widget _buildSelectButtons() {

    return _count >= (_talk?.talk?.length ?? 0) ? ScaleWidget(
      child: Column(
        children: _talk?.talk_options?.asMap().entries.map((entry) {
          return Container(
            margin: EdgeInsets.only(top: 10.dp, left: 20.dp, right: 20.dp),
            child: BorderButton(width: double.infinity, height: 36.dp,
              text: entry.value.option,
              textStyle: TextStyles.textMain16,
              color: Colours.transparent,
              borderColor: Colours.black,
              onPressed: () {
                if (entry.value.next_id == 0) {
                  widget.npc.next_id = entry.value.next_meet_id;
                  widget.onFinish();
                } else {
                  _talk = _meet?.getTalkById(entry.value.next_id ?? 0);
                  startAction();
                }
              },
            ),
          );
        }).toList() ?? [],
      ),
    ) : Gaps.empty;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.dp, vertical: 20.dp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(child: Column(children: _buildFade(_talk?.talk ?? []))),
            _buildSelectButtons()
          ],
        ),
      );
  }

}
