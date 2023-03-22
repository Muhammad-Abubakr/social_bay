part of 'photos_bloc.dart';

@immutable
abstract class PhotosState {
  final List<Photo> photos;

  const PhotosState(this.photos);
}

/* Initial State */
class PhotosInitial extends PhotosState {
  const PhotosInitial() : super(const []);
}

/* Update State */
class _PhotosUpdate extends PhotosState {
  const _PhotosUpdate(List<Photo> photos) : super(photos);
}
