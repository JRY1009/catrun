
import 'dart:math';

import 'package:catrun/game/config/app_config.dart';
import 'package:catrun/game/event/event.dart';
import 'package:catrun/game/event/player_event.dart';
import 'package:catrun/game/manager/action_mgr.dart';
import 'package:catrun/game/manager/enemy_mgr.dart';
import 'package:catrun/game/manager/fight_mgr.dart';
import 'package:catrun/game/manager/player_mgr.dart';
import 'package:catrun/game/manager/prop_mgr.dart';
import 'package:catrun/game/manager/random_event_mgr.dart';
import 'package:catrun/game/model/action.dart';
import 'package:catrun/game/model/enemy.dart';
import 'package:catrun/game/model/option.dart';
import 'package:catrun/game/model/player.dart';
import 'package:catrun/game/model/random_event.dart';
import 'package:catrun/mvvm/view_state_model.dart';

class EventModel extends ViewStateModel {

  bool _enableAction = true;
  bool _practiceVisible = false;
  bool _optionVisible = false;
  bool _fightVisible = false;

  Action? action;
  RandomEvent? randomEvent;
  Enemy? enemy;
  Fight? fightResult;
  int _animCount = 0;

  EventModel();

  int get animCount => _animCount;

  set animCount(int count) {
    _animCount = count;
    notifyListeners();
  }

  bool get actionVisible => (!_practiceVisible && !_optionVisible);

  bool get practiceVisible => _practiceVisible;

  set practiceVisible(bool visible) {
    if (_practiceVisible == visible) {
      return;
    }
    _practiceVisible = visible;
    notifyListeners();
  }

  bool get optionVisible => _optionVisible;

  set optionVisible(bool visible) {
    if (_optionVisible == visible) {
      return;
    }
    _optionVisible = visible;
    notifyListeners();
  }
  
  bool get fightVisible => _fightVisible;

  set fightVisible(bool visible) {
    if (_fightVisible == visible) {
      return;
    }
    _fightVisible = visible;
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
          randomEvent = RandomEventMgr.instance()!.getRandomEvent();
          if (randomEvent?.type == RandomEvent.event_type_property) {
            player?.makeDiffs(randomEvent?.diffs ?? []);
          } else if (randomEvent?.type == RandomEvent.event_type_option) {
            _optionVisible = true;
          } else if (randomEvent?.type == RandomEvent.event_type_fight) {
            enemy = EnemyMgr.instance()!.getEnemy(randomEvent?.enemy_id ?? 0);
            Future.delayed(Duration(milliseconds: 500), () {
              fightVisible = true;
            });
          } else if (randomEvent?.type == RandomEvent.event_type_pick) {
            player?.addProps(PropMgr.instance()!.getProps(randomEvent?.props) ?? []);
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
    _optionVisible = false;
    
    Player? player = PlayerMgr.instance()!.getPlayer();
    randomEvent = RandomEventMgr.instance()!.getSubEventById(option.id ?? 0);
    if (randomEvent?.type == RandomEvent.event_type_property) {
      player?.makeDiffs(randomEvent?.diffs ?? []);

    } else if (randomEvent?.type == RandomEvent.event_type_fight) {
      enemy = EnemyMgr.instance()!.getEnemy(randomEvent?.enemy_id ?? 0);
      Future.delayed(Duration(milliseconds: 500), () {
        fightVisible = true;
      });
    } else if (randomEvent?.type == RandomEvent.event_type_pick) {
      player?.addProps(PropMgr.instance()!.getProps(randomEvent?.props) ?? []);
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
      listStr = randomEvent?.desc ?? [''];
    } else {
      listStr = action?.desc ?? [''];
    }
    return listStr;
  }

  @override
  void dispose() {
    super.dispose();
  }
}