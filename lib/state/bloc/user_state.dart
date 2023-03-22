// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

@immutable
abstract class UserState {
  final user.User? currentUser;
  final List<user.User> followers;
  final List<Follower> following;
  final List<Community> communities;

  const UserState(this.currentUser, this.followers, this.following, this.communities);
}

class UserInitial extends UserState {
  const UserInitial(user.User? user, List<Community> communities, List<user.User> followers,
      List<Follower> following)
      : super(user, followers, following, communities);
}

class UserUpdate extends UserState {
  const UserUpdate(user.User? user, List<Community> communities, List<user.User> followers,
      List<Follower> following)
      : super(
          user,
          followers,
          following,
          communities,
        );
}
