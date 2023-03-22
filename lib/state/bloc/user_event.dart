part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

// Events
class UpdateUser extends UserEvent {
  final user.User currentUser;

  UpdateUser(this.currentUser) : super();
}

class UpdateCommunity extends UserEvent {
  final Community community;

  UpdateCommunity(this.community) : super();
}

class RemoveCommunity extends UserEvent {
  final Community community;

  RemoveCommunity(this.community) : super();
}

class UpdateFollowings extends UserEvent {
  final Follower following;

  UpdateFollowings(this.following) : super();
}

class RemoveFollowing extends UserEvent {
  final Follower following;

  RemoveFollowing(this.following) : super();
}
