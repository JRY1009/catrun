
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:catrun/game/config/app_config.dart';
import 'package:catrun/game/model/npc.dart';
import 'package:catrun/game/viewmodel/meet_model.dart';
import 'package:catrun/mvvm/provider_widget.dart';
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

  late MeetModel _meetModel;

  @override
  void initState() {
    super.initState();

    _meetModel = MeetModel();
    _meetModel.npc = widget.npc;
    _meetModel.meet = widget.npc.getMeetById(widget.npc.next_id ?? 0);
    _meetModel.talk = _meetModel.meet?.getTalkById(_meetModel.meet?.talk_id ?? 0);

    _meetModel.startAction();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Widget> _buildFade(List<String> listStr) {
    return listStr.asMap().entries.map((entry) {
      return _meetModel.animCount >= entry.key ? Container(
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
            _meetModel.animCount ++;
            if (_meetModel.animCount >= listStr.length) {
              _meetModel.finishAction();
            }
          },
        ),
      ) : Gaps.empty;
    }).toList();
  }

  Widget _buildSelectButtons() {

    return _meetModel.animCount >= (_meetModel.talk?.talk?.length ?? 0) ? ScaleWidget(
      child: Column(
        children: _meetModel.talk?.talk_options?.asMap().entries.map((entry) {
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
                  _meetModel.doAction(entry.value);
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
    return ProviderWidget<MeetModel>(
        model: _meetModel,
        builder: (context, model, child) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.dp, vertical: 20.dp),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(child: Column(children: _buildFade(_meetModel.getActionStr()))),
                _buildSelectButtons()
              ],
            ),
          );
        }
    );

  }

}
