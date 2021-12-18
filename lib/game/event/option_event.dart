import 'package:catrun/game/model/option.dart';

class OptionEvent {
  Option option;
  OptionEventState state;

  OptionEvent(this.option, this.state);
}

enum OptionEventState {
  action,
}
