import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_bay/state/bloc/follower_bloc.dart';
import 'package:social_bay/state/models/follower.dart';

class IFollowingPage extends StatelessWidget {
  const IFollowingPage({super.key});

  @override
  Widget build(BuildContext context) {
    FollowerBloc followerBloc = context.watch<FollowerBloc>();
    List<Follower> followings = followerBloc.getFollowings;

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Followings"),
      ),
      body: followings.isEmpty
          ? Center(
              child: Text(
                "People you follow will show here.",
                style: GoogleFonts.notoSans(
                  fontWeight: FontWeight.w500,
                  fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize ?? 24,
                ),
              ),
            )
          : ListView.separated(
              separatorBuilder: (context, index) => Divider(color: Colors.grey.shade800),
              itemBuilder: (context, index) => ListTile(
                leading: CircleAvatar(
                  backgroundImage: Image.network(
                    "${followings[index].photo.user.profileImage.medium}",
                    fit: BoxFit.cover,
                  ).image,
                ),
                title: Text(followings[index].photo.user.username),
                subtitle: Text(
                  followings[index].photo.user.bio ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: TextButton.icon(
                    onPressed: () => followerBloc.add(FollowingRemove(followings[index])),
                    icon: const Icon(Icons.remove_circle),
                    label: const Text("Unfollow")),
              ),
              itemCount: followings.length,
            ),
    );
  }
}
