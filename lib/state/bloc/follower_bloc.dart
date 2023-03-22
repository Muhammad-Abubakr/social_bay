import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_bay/state/bloc/photos_bloc.dart';
import 'package:social_bay/state/bloc/user_bloc.dart';
import 'package:unsplash_client/unsplash_client.dart';

import '../models/follower.dart';

part 'follower_event.dart';
part 'follower_state.dart';

class FollowerBloc extends Bloc<FollowerEvent, FollowerState> {
  PhotosBloc photosBloc;
  UserBloc userBloc;

  FollowerBloc(this.photosBloc, this.userBloc) : super(const FollowerInitial(followers: [])) {
    // Initiation
    on<InitFollowerEvent>(_onInitFollowing);

    // setting up stream subscription
    photosBloc.stream.listen((state) => add(InitFollowerEvent(state.photos)));

    add(InitFollowerEvent(photosBloc.state.photos));

    // handlers
    on<FollowingsUpdate>(_onFollowingsUpdate);
    on<FollowingRemove>(_onFollowingRemove);
  }

  // Event Handlers
  FutureOr<void> _onFollowingsUpdate(FollowingsUpdate event, Emitter<FollowerState> emit) {
    // Check if Already Joined
    int idx = state.followers.indexOf(event.following);

    print(idx);

    if (idx != -1) {
      Follower updatedFollowing = Follower(photo: state.followers[idx].photo, followed: true);

      state.followers.replaceRange(idx, idx + 1, [updatedFollowing]);

      final updatedFollowings = [...state.followers];

      // Updating the dependencies
      userBloc.add(UpdateFollowings(event.following));

      // Updating own state
      emit(FollowerUpdate(followers: updatedFollowings));
    }
  }

  FutureOr<void> _onFollowingRemove(FollowingRemove event, Emitter<FollowerState> emit) {
    //  Checking if present
    int idx = state.followers.indexOf(event.following);

    if (idx != -1) {
      // Updating the dependencies
      userBloc.add(RemoveFollowing(state.followers[idx]));

      // Updating own state
      Follower updatedCommunity = Follower(photo: state.followers[idx].photo, followed: false);

      state.followers.replaceRange(idx, idx + 1, [updatedCommunity]);

      final updatedFollowings = [...state.followers];

      emit(FollowerUpdate(followers: updatedFollowings));
    }
  }

  // -------------------- initiation ---------------------- //
  FutureOr<void> _onInitFollowing(InitFollowerEvent event, Emitter<FollowerState> emit) {
    List<Follower> followings =
        event.photos.map((photo) => Follower(photo: photo, followed: false)).toList();

    emit(FollowerUpdate(followers: followings));
  }

  // ---------- Getters ----------- //
  List<Follower> get getFollowings {
    return state.followers.where((following) => following.followed).toList();
  }
}
