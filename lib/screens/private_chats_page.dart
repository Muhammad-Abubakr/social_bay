import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_bay/state/bloc/follower_bloc.dart';

import '../state/models/follower.dart';
import '../widgets/private_chat.dart';

class PrivateChatsPage extends StatelessWidget {
  const PrivateChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Follower> followings = context.watch<FollowerBloc>().getFollowings;

    return followings.isEmpty
        ? Center(
            child: Text(
              "Follow a Person to Start Chatting.",
              style: GoogleFonts.notoSans(
                fontWeight: FontWeight.w500,
                fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize ?? 24,
              ),
            ),
          )
        : ListView.separated(
            padding: const EdgeInsets.only(top: 10),
            separatorBuilder: (context, index) => const Divider(color: Colors.black),
            itemBuilder: (context, index) => PrivateChat(followings[index]),
            itemCount: followings.length,
          );
  }
}
