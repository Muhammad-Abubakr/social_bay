import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_bay/state/bloc/community_bloc.dart';
import 'package:social_bay/state/models/community.dart';
import 'package:social_bay/widgets/group_chat.dart';

class GroupChatsPage extends StatelessWidget {
  const GroupChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Community> joinedCommunities = context.watch<CommunityBloc>().getJoinedCommunities;

    return joinedCommunities.isEmpty
        ? Center(
            child: Text(
              "Join a Community to Start Chatting.",
              style: GoogleFonts.notoSans(
                fontWeight: FontWeight.w500,
                fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize ?? 24,
              ),
            ),
          )
        : ListView.separated(
            padding: const EdgeInsets.only(top: 10),
            separatorBuilder: (context, index) => const Divider(color: Colors.black),
            itemBuilder: (context, index) => GroupChat(joinedCommunities[index]),
            itemCount: joinedCommunities.length,
          );
  }
}
