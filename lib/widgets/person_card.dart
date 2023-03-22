import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_bay/state/bloc/follower_bloc.dart';
import 'package:unsplash_client/unsplash_client.dart';

import '../state/bloc/user_bloc.dart';

class PersonCard extends StatelessWidget {
  final int index;

  const PersonCard(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    FollowerBloc followerBloc = context.watch<FollowerBloc>();
    UserBloc userBloc = context.watch<UserBloc>();

    bool followed = followerBloc.state.followers[index].followed;
    Photo? photo = followerBloc.state.followers[index].photo;

    return Container(
      height: MediaQuery.of(context).size.longestSide * 0.3,
      width: MediaQuery.of(context).size.longestSide * 0.3,
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade300,
        borderRadius: BorderRadius.circular(16),
        boxShadow: kElevationToShadow[1],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Images
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              "${photo.urls.regular}",
              fit: BoxFit.cover,
            ),
          ),

          // shade
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: kElevationToShadow[1],
            ),
          ),

          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CircleAvatar(
                child: Image.network(
                  "${photo.user.profileImage.large}",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            title: Text(
              photo.user.firstName,
              style: GoogleFonts.robotoCondensed(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
          /* bio */
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                photo.user.bio?.substring(
                        0, photo.user.bio!.length < 100 ? photo.user.bio!.length : 100) ??
                    "",
                textAlign: TextAlign.center,
                style: GoogleFonts.robotoCondensed(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          /* Join Button */
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton.icon(
              onPressed: () => _onPressedHandler(followed, followerBloc, userBloc),
              icon: Icon(
                  followed ? Icons.add_circle_rounded : Icons.add_circle_outline_rounded,
                  color: Colors.white),
              label: Text(followed ? "Followed" : "Follow",
                  style: GoogleFonts.roboto(color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }

  _onPressedHandler(bool followed, FollowerBloc followerBloc, UserBloc userBloc) {
    if (followed) {
      followerBloc.add(FollowingRemove(followerBloc.state.followers[index]));
    } else {
      followerBloc.add(FollowingsUpdate(followerBloc.state.followers[index]));
    }
  }
}
