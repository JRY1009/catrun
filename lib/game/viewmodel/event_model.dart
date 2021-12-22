
import 'dart:async';
import 'dart:math';

import 'package:catrun/game/config/app_config.dart';
import 'package:catrun/game/event/event.dart';
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
import 'package:catrun/game/model/revent.dart';
import 'package:catrun/mvvm/view_state_model.dart';

enum PanelState {
  normal,
  outside,
  practice,
  option,
  fight,
}

class EventModel extends ViewStateModel {

  bool _enableAction = true;
  PanelState _panelState = PanelState.normal;

  Action? action;
  REvent? revent;
  Enemy? enemy;
  Fight? fightResult;
  int _animCount = 0;

  StreamSubscription? optionSubscription;

  EventModel();

  void listenEvent() {

    optionSubscription?.cancel();
    optionSubscription = Event.eventBus.on<OptionEvent>().listen((event) {
      action = Action(id: Action.id_act_goout);
      startOption(event.option);
    });
  }

  PanelState get panelState => _panelState;
  bool get isNormalState => _panelState == PanelState.normal;
  bool get isOutsideState => _panelState == PanelState.outside;
  bool get isPracticeState => _panelState == PanelState.practice;
  bool get isOptionState => _panelState == PanelState.option;
  bool get isFightState => _panelState == PanelState.fight;

  set panelState(PanelState state) {
    _panelState = state;
    notifyListeners();
  }

  int get animCount => _animCount;

  set animCount(int count) {
    _animCount = count;
    notifyListeners();
  }

  void startAction(Action? act, {bool burn = true}) {

    if (burn) {
      if (!_enableAction) {
        return;
      }
      _enableAction = false;

      Player? player = PlayerMgr.instance()!.getPlayer();
      if ((player?.energy ?? 0) <= 0) {
        action = ActionMgr.instance()!.getAction(Action.id_act_rest_need);

      } else {
        action = act;
        player?.energy = max((player.energy ?? 0) - AppConfig.burnEnergy, 0);

        if (action?.id == Action.id_act_goout) {
          revent = REventMgr.instance()!.getRandomEvent();
          if (revent?.type == REvent.event_type_property) {
            player?.makeDiffs(revent?.diffs ?? []);
          } else if (revent?.type == REvent.event_type_option) {
            _panelState = PanelState.option;
          } else if (revent?.type == REvent.event_type_fight) {
            enemy = EnemyMgr.instance()!.getEnemy(revent?.enemy_id ?? 0);
            Future.delayed(Duration(milliseconds: 500), () {
              panelState = PanelState.fight;
            });
          } else if (revent?.type == REvent.event_type_pick) {
            player?.addProps(PropMgr.instance()!.getProps(revent?.props) ?? []);
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
  }

  void startOption(Option option) {

    if (!_enableAction) {
      return;
    }
    _enableAction = false;
    _panelState = PanelState.normal;
    
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
      player?.addProps(PropMgr.instance()!.getProps(revent?.props) ?? []);
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
    } else if (action?.id == Action.id_act_goout) {
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