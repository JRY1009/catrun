
import 'dart:async';

import 'package:catrun/game/event/event.dart';
import 'package:catrun/game/event/time_event.dart';
import 'package:catrun/mvvm/view_state_model.dart';

class TimeModel extends ViewStateModel {

  StreamSubscription? timeSubscription;

  TimeModel();

  void listenEvent() {
    timeSubscription?.cancel();
    timeSubscription = Event.eventBus.on<TimeEvent>().listen((event) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    timeSubscription?.cancel();
    super.dispose();
  }
}