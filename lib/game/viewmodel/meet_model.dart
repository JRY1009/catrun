
import 'dart:async';

import 'package:catrun/game/manager/fight_mgr.dart';
import 'package:catrun/game/model/meet.dart';
import 'package:catrun/game/model/npc.dart';
import 'package:catrun/game/model/talk.dart';
import 'package:catrun/mvvm/view_state_model.dart';

enum MeetState {
  meet,
  fight,
}

class MeetModel extends ViewStateModel {

  bool _enableAction = true;
  MeetState _panelState = MeetState.meet;

  Npc? npc;
  Meet? meet;
  Talk? talk;
  TalkOption? talkOption;
  
  Fight? fightResult;
  int _animCount = 0;

  StreamSubscription? optionSubscription;

  MeetModel();

  void listenEvent() {
    optionSubscription?.cancel();
  }

  MeetState get panelState => _panelState;
  bool get isMeetState => _panelState == MeetState.meet;
  bool get isFightState => _panelState == MeetState.fight;

  set panelState(MeetState state) {
    _panelState = state;
    notifyListeners();
  }

  int get animCount => _animCount;

  set animCount(int count) {
    _animCount = count;
    notifyListeners();
  }

  void doAction(TalkOption option) {
    talkOption = option;

    if (option.check_require ?? false) {
      bool check = meet?.checkRequire() ?? false;
      if (check) {
        talk = meet?.getTalkById(option.next_id ?? 0);
      } else {
        talk = meet?.getTalkById(option.none_id ?? 0);
      }
      startAction();

    } else if (option.fight ?? false) {
      Future.delayed(Duration(milliseconds: 100), () {
        panelState = MeetState.fight;
      });

    } else {
      talk = meet?.getTalkById(option.next_id ?? 0);
      startAction();
    }
  }

  void startAction() {
    if (!_enableAction) {
      return;
    }
    _enableAction = false;
    
    _animCount = -1;
    notifyListeners();

    Future.delayed(Duration(milliseconds: 100), () {
      _animCount = 0;
      notifyListeners();
    });
  }
  
  void finishAction() {
    _enableAction = true;
  }

  void finishFight(Fight result) {
    panelState = MeetState.meet;
    fightResult = result;

    if (fightResult?.status == FightStatus.win) {
      talk = meet?.getTalkById(talkOption?.next_id ?? 0);
    } else {
      talk = meet?.getTalkById(talkOption?.none_id ?? 0);
    }
    startAction();
  }

  List<String> getActionStr() {
    List<String> listStr = talk?.talk ?? [''];
    return listStr;
  }

  @override
  void dispose() {
    optionSubscription?.cancel();
    super.dispose();
  }
}