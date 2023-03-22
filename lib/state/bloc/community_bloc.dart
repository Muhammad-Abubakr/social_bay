import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_bay/state/bloc/photos_bloc.dart';
import 'package:social_bay/state/bloc/user_bloc.dart';
import 'package:social_bay/state/models/community.dart';
import 'package:unsplash_client/unsplash_client.dart';

part 'community_event.dart';
part 'community_state.dart';

class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  PhotosBloc photosBloc;
  UserBloc userBloc;

  CommunityBloc(this.photosBloc, this.userBloc)
      : super(const CommunityInitial(communities: [])) {
    // One Time Emittence
    on<InitCommunity>(_onInitCommunity);

    // adding a stream subscription to listen to the changes in products
    // and synchronize the changes with it
    photosBloc.stream.listen((state) {
      add(InitCommunity(photos: state.photos));
    });

    add(InitCommunity(photos: photosBloc.state.photos));

    // events
    on<JoinCommunity>(_handleJoinCommunity);
    on<DisjoinCommunity>(_handleDisjoinCommunity);
  }

  // Handlers
  FutureOr<void> _handleJoinCommunity(JoinCommunity event, Emitter<CommunityState> emit) {
    // Check if Already Joined
    int idx = state.communities.indexOf(event.community);

    if (idx != -1) {
      Community updatedCommunity =
          Community(photo: state.communities[idx].photo, joined: true);

      state.communities.replaceRange(idx, idx + 1, [updatedCommunity]);

      final updatedCommunities = [...state.communities];

      // Updating the dependencies
      userBloc.add(UpdateCommunity(event.community));

      // Updating own state
      emit(CommunityUpdate(communities: updatedCommunities));
    }
  }

  FutureOr<void> _handleDisjoinCommunity(
      DisjoinCommunity event, Emitter<CommunityState> emit) {
    //  Checking if present
    int idx = state.communities.indexOf(event.community);

    if (idx != -1) {
      // Updating the dependencies
      userBloc.add(RemoveCommunity(state.communities[idx]));

      // Updating own state
      Community updatedCommunity =
          Community(photo: state.communities[idx].photo, joined: false);

      state.communities.replaceRange(idx, idx + 1, [updatedCommunity]);

      final updatedCommunities = [...state.communities];

      emit(CommunityUpdate(communities: updatedCommunities));
    }
  }

// Invoked Once
  FutureOr<void> _onInitCommunity(InitCommunity event, Emitter<CommunityState> emit) {
    List<Community> communities =
        event.photos.map((photo) => Community(photo: photo, joined: false)).toList();

    emit(CommunityUpdate(communities: communities));
  }

  // Utilities
  List<Community> get getJoinedCommunities {
    return state.communities.where((com) => com.joined).toList();
  }
}
