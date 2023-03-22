// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(const LocationInitial(null, null)) {
    on<FetchUserLocation>(_fetchUserLocation);
  }
  // Getting the Location of the User

  FutureOr<void> _fetchUserLocation(
      FetchUserLocation event, Emitter<LocationState> emit) async {
    // get the required permissions
    await Geolocator.requestPermission();

    // get the location
    Position? location = await Geolocator.getLastKnownPosition(
      forceAndroidLocationManager: true,
    );

    // translate the position
    if (location != null) {
      List<Placemark> placemark =
          await placemarkFromCoordinates(location.latitude, location.longitude);

      return emit(LocationUpdate(location, placemark));
    }
    // update the location
    emit(LocationUpdate(location, null));
  }
}
