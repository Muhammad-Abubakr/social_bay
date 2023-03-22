part of 'follower_bloc.dart';

@immutable
abstract class FollowerEvent {}

class InitFollowerEvent extends FollowerEvent {
  final List<Photo> photos;

  InitFollowerEvent(this.photos);
}

class FollowingsUpdate extends FollowerEvent {
  final Follower following;

  FollowingsUpdate(this.following);
}

class FollowingRemove extends FollowerEvent {
  final Follower following;

  FollowingRemove(this.following);
}
