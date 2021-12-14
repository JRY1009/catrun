
import 'dart:async';

import 'package:catrun/game/event/event.dart';
import 'package:catrun/game/event/player_event.dart';
import 'package:catrun/mvvm/view_state_model.dart';
import 'package:flutter/material.dart';

class PlayerModel extends ViewStateModel {

  late BuildContext context;
  StreamSubscription? playerSubscription;

  PlayerModel();

  void listenEvent(BuildContext context) {
    this.context = context;

    playerSubscription?.cancel();
    playerSubscription = Event.eventBus.on<PlayerEvent>().listen((event) {
      notifyListeners();
    });
  }
  
  @override
  void dispose() {
    playerSubscription?.cancel();
    super.dispose();
  }
}