
class LocationEvent {
  LocationState state;
  OutsideLocation outside;

  LocationEvent(this.state, {this.outside = OutsideLocation.unknown});
}

enum LocationState {
  home,
  outside,
}

enum OutsideLocation {
  unknown,
  garden,
  recycle,
  shop,
  market,
  station,
  hospital,
}