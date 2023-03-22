// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'community_bloc.dart';

@immutable
abstract class CommunityEvent {}

// User Defined Events
class InitCommunity extends CommunityEvent {
  final List<Photo> photos;
  InitCommunity({required this.photos});
}

class JoinCommunity extends CommunityEvent {
  final Community community;
  JoinCommunity({required this.community});
}

class DisjoinCommunity extends CommunityEvent {
  final Community community;
  DisjoinCommunity({required this.community});
}
