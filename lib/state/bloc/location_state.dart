part of 'location_bloc.dart';

@immutable
abstract class LocationState {
  final Position? userLocation;
  final List<Placemark>? placemark;

  const LocationState(this.userLocation, this.placemark);
}

// Initial User Location
class LocationInitial extends LocationState {
  const LocationInitial(Position? userLocation, List<Placemark>? placemark)
      : super(userLocation, placemark);
}

// Location Update
class LocationUpdate extends LocationState {
  const LocationUpdate(Position? userLocation, List<Placemark>? placemark)
      : super(userLocation, placemark);
}
