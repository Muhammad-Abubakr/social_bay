import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:social_bay/state/models/community.dart';
import 'package:unsplash_client/unsplash_client.dart';
import '../models/follower.dart';
import '../models/user.dart' as user;

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc()
      : super(UserInitial(
          user.User(
            id: '${DateTime.now()}',
            username: 'Username',
            bio: 'Dummy Bio',
            userPic: null,
          ),
          const [],
          const [],
          const [],
        )) {
    // Required Permissions
    _getPermissions();

    // Handlers
    on<UpdateUser>(_handleUpdateUser);
    on<UpdateCommunity>(_handleUpdateCommunity);
    on<RemoveCommunity>(_handleRemoveCommunity);
    on<UpdateFollowings>(_handleUpdateFollowings);
    on<RemoveFollowing>(_handleRemoveFollowing);
  }

  // User Update
  FutureOr<void> _handleUpdateUser(UpdateUser event, Emitter<UserState> emit) {
    // emit the updated state
    emit(UserUpdate(
      event.currentUser,
      state.communities,
      state.followers,
      state.following,
    ));
  }

  // ----------------------- Communities -------------------------- //

  FutureOr<void> _handleUpdateCommunity(UpdateCommunity event, Emitter<UserState> emit) {
    // check if already present
    int idx = state.communities.indexOf(event.community);

    if (idx == -1) {
      final updatedCommunities = [...state.communities, event.community];

      emit(UserUpdate(
        state.currentUser,
        updatedCommunities,
        state.followers,
        state.following,
      ));
    }
  }

  FutureOr<void> _handleRemoveCommunity(RemoveCommunity event, Emitter<UserState> emit) {
    // remove instances
    state.communities.removeWhere((element) => element.photo.id == event.community.photo.id);

    final updatedCommunities = [...state.communities];

    emit(UserUpdate(
      state.currentUser,
      updatedCommunities,
      state.followers,
      state.following,
    ));
  }
  // ----------------------- Followings -------------------------- //

  FutureOr<void> _handleUpdateFollowings(UpdateFollowings event, Emitter<UserState> emit) {
    // check if already present
    int idx = state.following.indexOf(event.following);

    if (idx == -1) {
      final updatedFollowing = [...state.following, event.following];

      emit(UserUpdate(
        state.currentUser,
        state.communities,
        state.followers,
        updatedFollowing,
      ));
    }
  }

  FutureOr<void> _handleRemoveFollowing(RemoveFollowing event, Emitter<UserState> emit) {
    // remove instances
    state.following.removeWhere((element) => element.photo.id == event.following.photo.id);

    final updatedFollowing = [...state.following];

    emit(UserUpdate(
      state.currentUser,
      state.communities,
      state.followers,
      updatedFollowing,
    ));
  }

  // setup
  void _getPermissions() async {
    // You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.photos,
      Permission.storage,
      Permission.manageExternalStorage,
    ].request();
  }
}
