part of 'location_bloc.dart';

@immutable
abstract class LocationEvent {}

// Fetch User Location
class FetchUserLocation extends LocationEvent {}
