
import 'package:catrun/game/event/event.dart';
import 'package:catrun/game/event/time_event.dart';

class TimeMgr {

  static TimeMgr? _instance;

  static TimeMgr? instance() {
    if (_instance == null) {
      _instance = new TimeMgr();
    }
    return _instance;
  }

  int _day = 1;

  int getDay() => _day;

  nextDay() {
    _day++;
    Event.eventBus.fire(TimeEvent(TimeEventState.update));
  }
}
