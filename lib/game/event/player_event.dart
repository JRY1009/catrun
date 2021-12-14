


import 'package:catrun/game/model/player.dart';

class PlayerEvent {
  Player? player;
  PlayerEventState state;

  PlayerEvent(this.player, this.state);
}

enum PlayerEventState {
  update,
}
