
import 'dart:async';

import 'package:catrun/game/event/event.dart';
import 'package:catrun/game/event/location_event.dart';
import 'package:catrun/game/event/player_event.dart';
import 'package:catrun/game/manager/action_mgr.dart';
import 'package:catrun/game/manager/player_mgr.dart';
import 'package:catrun/game/model/action.dart';
import 'package:catrun/mvvm/view_state_model.dart';


class PlayerModel extends ViewStateModel {

  StreamSubscription? playerSubscription;
  StreamSubscription? locationSubscription;

  LocationState _location = LocationState.home;
  bool get isHome => _location == LocationState.home;
  bool get isOutSide => _location == LocationState.outside;

  OutsideLocation _outside = OutsideLocation.unknown;
  bool get isGarden => _outside == OutsideLocation.garden;
  bool get isRecycle => _outside == OutsideLocation.recycle;
  bool get isShop => _outside == OutsideLocation.shop;
  bool get isMarket => _outside == OutsideLocation.market;
  bool get isStation => _outside == OutsideLocation.station;
  bool get isHospital => _outside == OutsideLocation.hospital;

  String getLocationStr() {
    if (_outside == OutsideLocation.unknown) {
      return '';
    }

    num id = Action.switch2Action(_outside);
    Action? action = ActionMgr.instance()!.getAction(id);

    return action?.name ?? '';
  }

  PlayerModel() {
    _location = PlayerMgr.instance()!.getLocationState();
    _outside = PlayerMgr.instance()!.getOutsideLocation();
  }

  void listenEvent() {
    playerSubscription?.cancel();
    playerSubscription = Event.eventBus.on<PlayerEvent>().listen((event) {
      notifyListeners();
    });

    locationSubscription?.cancel();
    locationSubscription = Event.eventBus.on<LocationEvent>().listen((event) {
      _location = event.state;
      _outside = event.outside;

      notifyListeners();
    });
  }
  
  @override
  void dispose() {
    playerSubscription?.cancel();
    locationSubscription?.cancel();
    super.dispose();
  }
}