
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
import 'package:catrun/game/manager/player_mgr.dart';
import 'package:catrun/game/manager/prop_mgr.dart';
import 'package:catrun/game/manager/revent_mgr.dart';
import 'package:catrun/game/model/action.dart';
import 'package:catrun/game/model/enemy.dart';
import 'package:catrun/game/model/option.dart';
import 'package:catrun/game/model/player.dart';
import 'package:catrun/game/model/prop.dart';
import 'package:catrun/game/model/revent.dart';
import 'package:catrun/mvvm/view_state_model.dart';

enum PanelState {
  home,
  outside,
  practice,
  option,
  fight,
  propOption,
}

class EventModel extends ViewStateModel {

  bool _enableAction = true;
  PanelState _panelState = PanelState.home;
  PanelState _lastState = PanelState.home;

  Action? action;
  REvent? revent;
  Enemy? enemy;
  Fight? fightResult;
  Prop? optionProp;
  int _animCount = 0;

  StreamSubscription? optionSubscription;

  EventModel();

  void listenEvent() {

    optionSubscription?.cancel();
    optionSubscription = Event.eventBus.on<OptionEvent>().listen((event) {
      action = Action(id: Action.id_act_option);
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

  set panelState(PanelState state) {
    _lastState = state == PanelState.home ? state : _panelState;
    _panelState = state;

    if (state == PanelState.home) {
      Event.eventBus.fire(LocationEvent(LocationState.home));
    } else if (state == PanelState.outside) {
      Event.eventBus.fire(LocationEvent(LocationState.outside));
    }
    notifyListeners();
  }

  int get animCount => _animCount;

  set animCount(int count) {
    _animCount = count;
    notifyListeners();
  }

  bool startAction(Action? act, {bool burn = true}) {

    bool ret = true;
    if (burn) {
      if (!_enableAction) {
        return false;
      }
      _enableAction = false;

      Player? player = PlayerMgr.instance()!.getPlayer();
      if ((player?.energy ?? 0) <= 0) {
        action = ActionMgr.instance()!.getAction(Action.id_act_rest_need);
        ret = false;

      } else if (((player?.energy ?? 0) <= AppConfig.burnEnergy) && isOutsideState) {
        action = ActionMgr.instance()!.getAction(Action.id_act_gohome_need);
        ret = false;

      } else if (((player?.energy ?? 0) <= AppConfig.burnEnergy) && isHomeState && act?.id == Action.id_act_goout) {
        action = ActionMgr.instance()!.getAction(Action.id_act_goout_banned);
        ret = false;

      } else {
        action = act;
        player?.energy = max((player.energy ?? 0) - AppConfig.burnEnergy, 0);

        if (action?.id == Action.id_act_outside_stroll) {
          revent = REventMgr.instance()!.getRandomEvent();
          if (revent?.type == REvent.event_type_property) {
            player?.makeDiffs(revent?.diffs ?? []);
          } else if (revent?.type == REvent.event_type_option) {
            panelState = PanelState.option;
          } else if (revent?.type == REvent.event_type_fight) {
            enemy = EnemyMgr.instance()!.getEnemy(revent?.enemy_id ?? 0);
            Future.delayed(Duration(milliseconds: 500), () {
              panelState = PanelState.fight;
            });
          } else if (revent?.type == REvent.event_type_pick) {
            optionProp = revent?.props?[0];
            panelState = PanelState.propOption;
          }
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

  void startOption(Option option) {

    if (!_enableAction) {
      return;
    }
    _enableAction = false;
    _panelState = _lastState;
    
    Player? player = PlayerMgr.instance()!.getPlayer();
    revent = REventMgr.instance()!.getOptionEventById(option.id ?? 0);
    if (revent?.type == REvent.event_type_property) {
      player?.makeDiffs(revent?.diffs ?? []);

    } else if (revent?.type == REvent.event_type_fight) {
      enemy = EnemyMgr.instance()!.getEnemy(revent?.enemy_id ?? 0);
      Future.delayed(Duration(milliseconds: 500), () {
        panelState = PanelState.fight;
      });
    } else if (revent?.type == REvent.event_type_pick) {
      optionProp = revent?.props?[0];
      panelState = PanelState.propOption;
    }
    
    Event.eventBus.fire(PlayerEvent(player, PlayerEventState.update));

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

  List<String> getActionStr() {
    List<String> listStr = [''];
    if (action?.id == Action.id_act_fight_finish) {
      listStr = [fightResult?.desc ?? ''];

    } else if (action?.id == Action.id_act_option ||
        action?.id == Action.id_act_outside_stroll) {
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