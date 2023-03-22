// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'follower_bloc.dart';

@immutable
abstract class FollowerState {
  final List<Follower> followers;
  const FollowerState({required this.followers});
}

class FollowerInitial extends FollowerState {
  const FollowerInitial({required super.followers});
}

class FollowerUpdate extends FollowerState {
  const FollowerUpdate({required super.followers});
}
