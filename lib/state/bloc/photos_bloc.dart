// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:unsplash_client/unsplash_client.dart';

import '../apis/unsplash.dart';

part 'photos_event.dart';
part 'photos_state.dart';

class PhotosBloc extends Bloc<PhotosEvent, PhotosState> {
  // Initializing State
  PhotosBloc() : super(const PhotosInitial()) {
    // On Event
    on<FetchPhotos>(fetchPhotosHandler);
  }

  // Handlers
  void fetchPhotosHandler(event, emit) async {
    // fetch the photos from the client
    List<Photo> fetchedPhotos = await client.photos.random(count: 15).goAndGet();

    // update the state
    emit(_PhotosUpdate(fetchedPhotos));
  }
}
