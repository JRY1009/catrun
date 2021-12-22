
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:catrun/game/config/app_config.dart';
import 'package:catrun/game/event/event.dart';
import 'package:catrun/game/event/option_event.dart';
import 'package:catrun/game/event/player_event.dart';
import 'package:catrun/game/manager/player_mgr.dart';
import 'package:catrun/game/manager/prop_mgr.dart';
import 'package:catrun/game/manager/story_mgr.dart';
import 'package:catrun/game/manager/time_mgr.dart';
import 'package:catrun/game/model/player.dart';
import 'package:catrun/game/model/story.dart';
import 'package:catrun/game/page/main_page.dart';
import 'package:catrun/generated/l10n.dart';
import 'package:catrun/res/colors.dart';
import 'package:catrun/res/gaps.dart';
import 'package:catrun/res/styles.dart';
import 'package:catrun/router/routers.dart';
import 'package:catrun/utils/screen_util.dart';
import 'package:catrun/widget/animate/fade_in_text.dart';
import 'package:catrun/widget/animate/scale_widget.dart';
import 'package:catrun/widget/button/border_button.dart';
import 'package:flutter/material.dart';

class StoryPage extends StatefulWidget {

  StoryPage({
    Key? key,
  }): super(key: key);

  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {

  int _count = 0;

  Story? _story;

  @override
  void initState() {
    super.initState();

    int day = TimeMgr.instance()!.getDay();
    _story = StoryMgr.instance()!.getStory(day);

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
            FadeInAnimatedText(entry.value, textAlign: TextAlign.center, textStyle: TextStyles.textWhite16_w700),
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

  Widget _buildConfirmButton() {
    return _count >= (_story?.desc?.length ?? 0) ? ScaleWidget(
      child: BorderButton(width: 108.dp, height: 36.dp,
        text: S.of(context).confirm,
        textStyle: TextStyles.textWhite16,
        color: Colours.transparent,
        borderColor: Colours.white,
        onPressed: () {
          Player? player = PlayerMgr.instance()!.getPlayer();
          player?.addProps(PropMgr.instance()!.getProps(_story?.props) ?? []);
          player?.makeDiffs(_story?.diffs ?? []);
          Event.eventBus.fire(PlayerEvent(null, PlayerEventState.update));

          if (sMainContext == null) {
            Routers.goBack(context);
            Routers.navigateTo(context, Routers.mainPage);
          } else {
            Routers.goBack(context);
          }
        },
      ),
    ) : Gaps.empty;
  }

  Widget _buildSelectButtons() {

    return _count >= (_story?.desc?.length ?? 0) ? ScaleWidget(
      child: Column(
        children: _story?.options?.asMap().entries.map((entry) {
          return Container(
            margin: EdgeInsets.only(top: 10, left: 20, right: 20),
            child: BorderButton(width: double.infinity, height: 36.dp,
              text: entry.value.option,
              textStyle: TextStyles.textWhite16,
              color: Colours.transparent,
              borderColor: Colours.white,
              onPressed: () {

                Event.eventBus.fire(OptionEvent(entry.value, OptionEventState.action));

                if (sMainContext == null) {
                  Routers.goBack(context);
                  Routers.navigateTo(context, Routers.mainPage);
                } else {
                  Routers.goBack(context);
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
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.dp, vertical: 20.dp),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(child: Column(children: _buildFade(_story?.desc ?? []))),
                _story?.type == 2 ? _buildSelectButtons() : _buildConfirmButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

}
