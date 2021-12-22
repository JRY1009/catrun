
import 'dart:async';

import 'package:catrun/game/event/event.dart';
import 'package:catrun/game/event/location_event.dart';
import 'package:catrun/game/event/player_event.dart';
import 'package:catrun/mvvm/view_state_model.dart';


class PlayerModel extends ViewStateModel {

  StreamSubscription? playerSubscription;
  StreamSubscription? locationSubscription;

  LocationState _location = LocationState.home;
  bool get isHome => _location == LocationState.home;
  bool get isOutSide => _location == LocationState.outside;

  PlayerModel();

  void listenEvent() {
    playerSubscription?.cancel();
    playerSubscription = Event.eventBus.on<PlayerEvent>().listen((event) {
      notifyListeners();
    });

    locationSubscription?.cancel();
    locationSubscription = Event.eventBus.on<LocationEvent>().listen((event) {
      _location = event.state;
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