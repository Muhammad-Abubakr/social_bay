part of 'photos_bloc.dart';

@immutable
abstract class PhotosEvent {}

// User defined Events
class FetchPhotos extends PhotosEvent {
  FetchPhotos() : super();
}
