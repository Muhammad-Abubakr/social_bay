// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'community_bloc.dart';

@immutable
abstract class CommunityState {
  final List<Community> communities;

  const CommunityState({required this.communities});
}

class CommunityInitial extends CommunityState {
  const CommunityInitial({required super.communities});
}

class CommunityUpdate extends CommunityState {
  const CommunityUpdate({required super.communities});
}
