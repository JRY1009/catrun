
import 'dart:async';
import 'dart:math';

import 'package:catrun/game/config/app_config.dart';
import 'package:catrun/game/event/event.dart';
import 'package:catrun/game/event/location_event.dart';
import 'package:catrun/game/event/option_event.dart';
import 'package:catrun/game/event/player_event.dart';
import 'package:catrun/game/manager/action_mgr.dart';
import 'package:catrun/game/manager/enemy_mgr.dart';
import 'package:catrun/game/manager/fight_mgr.dart';
import 'package:catrun/game/manager/npc_mgr.dart';
import 'package:catrun/game/manager/player_mgr.dart';
import 'package:catrun/game/manager/revent_mgr.dart';
import 'package:catrun/game/model/action.dart';
import 'package:catrun/game/model/enemy.dart';
import 'package:catrun/game/model/npc.dart';
import 'package:catrun/game/model/option.dart';
import 'package:catrun/game/model/player.dart';
import 'package:catrun/game/model/prop.dart';
import 'package:catrun/game/model/revent.dart';
import 'package:catrun/generated/l10n.dart';
import 'package:catrun/mvvm/view_state_model.dart';
import 'package:catrun/router/routers.dart';
import 'package:flutter/material.dart' hide Action;

enum PanelState {
  home,
  outside,
  practice,
  option,
  fight,
  propOption,
  meet,
}

class EventModel extends ViewStateModel {

  bool _enableAction = true;
  bool _postEvent = false;
  PanelState _panelState = PanelState.home;
  PanelState _lastState = PanelState.home;

  Action? action;
  REvent? revent;
  Enemy? enemy;
  Fight? fightResult;
  Prop? optionProp;
  Npc? npc;
  int _animCount = 0;

  StreamSubscription? optionSubscription;

  EventModel();

  void listenEvent() {

    optionSubscription?.cancel();
    optionSubscription = Event.eventBus.on<OptionEvent>().listen((event) {
      action = Action(id: Action.action_option);
      startOption(event.option);
    });
  }

  PanelState get lastState => _lastState;
  PanelState get panelState => _panelState;
  bool get isHomeState => _panelState == PanelState.home;
  bool get isOutsideState => _panelState == PanelState.outside;
  bool get isPracticeState => _panelState == PanelState.practice;
  bool get isOptionState => _panelState == PanelState.option;
  bool get isFightState => _panelState == PanelState.fight;
  bool get isPropOptionState => _panelState == PanelState.propOption;
  bool get isMeetState => _panelState == PanelState.meet;

  set panelState(PanelState state) {
    _lastState = state == PanelState.home ? state : _panelState;
    _panelState = state;

    if (state == PanelState.home) {
      PlayerMgr.instance()!.setLocationState(LocationState.home);
    } else if (state == PanelState.outside) {
      PlayerMgr.instance()!.setLocationState(LocationState.outside);
    }
    notifyListeners();
  }

  int get animCount => _animCount;

  set animCount(int count) {
    _animCount = count;
    notifyListeners();
  }

  void doAction(BuildContext context, Action? action) {

    if (action?.id == Action.action_practice) {
      panelState = PanelState.practice;
    } else if (action?.id == Action.action_back) {
      panelState = PanelState.home;

    } else if (action?.id == Action.action_goout) {
      if (startAction(action)) {
        panelState = PanelState.outside;
      }

    } else if (action?.id == Action.action_outside_gohome) {
      panelState = PanelState.home;
      startAction(action);

    } else if (action?.id == Action.action_rest) {
      startAction(action, burnEnergy: false);
      Routers.navigateTo(context, Routers.timePage);

    } else if (action?.id == Action.action_warehouse) {
      Routers.navigateTo(context, Routers.warehousePage);

    } else {
      startAction(action);
    }
  }

  bool startAction(Action? act, {bool burnEnergy = true}) {

    bool ret = true;
    if (burnEnergy) {
      if (!_enableAction) {
        return false;
      }
      _enableAction = false;

      Player? player = PlayerMgr.instance()!.getPlayer();
      if ((player?.energy ?? 0) <= 0) {
        action = ActionMgr.instance()!.getAction(Action.action_rest_need);
        ret = false;

      } else if (((player?.energy ?? 0) <= AppConfig.burnEnergy) && isOutsideState) {
        action = ActionMgr.instance()!.getAction(Action.action_gohome_need);
        ret = false;

      } else if (((player?.energy ?? 0) <= AppConfig.burnEnergy) && isHomeState && act?.id == Action.action_goout) {
        action = ActionMgr.instance()!.getAction(Action.action_goout_banned);
        ret = false;

      } else {
        action = act;
        player?.energy = max((player.energy ?? 0) - AppConfig.burnEnergy, 0);

        if (Action.isOutsideAction(action?.id ?? 0)) {
          OutsideLocation outside = Action.switch2Location(action?.id ?? 0);
          PlayerMgr.instance()!.setOutsideLocation(outside);

          REvent? event = REventMgr.instance()!.getRandomEvent();
          event?.desc = [S.current.come2Spl('${action?.name}'), ...event.desc??[]];
          postEvent(event);

        } else if (Action.isOutsideSubAction(action?.id ?? 0)) {
          REvent? event = REventMgr.instance()!.getRandomEvent();
          postEvent(event);

        } else {
          player?.makeDiffs(action?.diffs ?? []);
        }
      }

      Event.eventBus.fire(PlayerEvent(player, PlayerEventState.update));

    } else {
      action = act;
    }

    _animCount = -1;
    notifyListeners();

    Future.delayed(Duration(milliseconds: 100), () {
      _animCount = 0;
      notifyListeners();
    });

    return ret;
  }

  void doMeet(BuildContext context, Action? action) {
    if (!_enableAction) {
      return;
    }
    
    npc = NpcMgr.instance()!.getNpc(action?.id ?? 0);
    panelState = PanelState.meet;

    startAction(action);
  }

  void startOption(Option option) {

    if (!_enableAction) {
      return;
    }
    _enableAction = false;
    _panelState = _lastState;

    postEvent(REventMgr.instance()!.getOptionEventById(option.id ?? 0));

    _animCount = -1;
    notifyListeners();

    Future.delayed(Duration(milliseconds: 100), () {
      _animCount = 0;
      notifyListeners();
    });
  }

  void postEvent(REvent? event) {
    revent = event;
    _postEvent = true;
  }

  void handleEvent() {
    if (_postEvent) {
      _postEvent = false;
      Player? player = PlayerMgr.instance()!.getPlayer();

      if (revent?.type == REvent.event_type_property) {
        player?.makeDiffs(revent?.diffs ?? []);

      } else if (revent?.type == REvent.event_type_option) {
        panelState = PanelState.option;

      } else if (revent?.type == REvent.event_type_fight) {
        enemy = EnemyMgr.instance()!.getEnemy(revent?.enemy_id ?? 0);
        Future.delayed(Duration(milliseconds: 400), () {
          panelState = PanelState.fight;
        });
      } else if (revent?.type == REvent.event_type_pick) {
        optionProp = revent?.props?[0];
        panelState = PanelState.propOption;
      }

      Event.eventBus.fire(PlayerEvent(player, PlayerEventState.update));
    }
  }

  void finishAction() {
    _enableAction = true;
  }

  List<String> getActionStr() {
    List<String> listStr = [''];
    if (action?.id == Action.action_fight_finish) {
      listStr = [fightResult?.desc ?? ''];

    } else if (action?.id == Action.action_option ||
        Action.isOutsideAction(action?.id ?? 0) ||
        Action.isOutsideSubAction(action?.id ?? 0)) {
      listStr = revent?.desc ?? [''];

    } else {
      listStr = action?.desc ?? [''];
    }
    return listStr;
  }

  @override
  void dispose() {
    optionSubscription?.cancel();
    super.dispose();
  }
}