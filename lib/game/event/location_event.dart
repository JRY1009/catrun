
class LocationEvent {
  LocationState state;

  LocationEvent(this.state);
}

enum LocationState {
  home,
  outside,
}