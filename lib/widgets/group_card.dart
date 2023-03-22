import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_bay/state/bloc/community_bloc.dart';
import 'package:unsplash_client/unsplash_client.dart';

import '../state/bloc/user_bloc.dart';

class GroupCard extends StatelessWidget {
  final int index;

  const GroupCard(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    CommunityBloc communityBloc = context.watch<CommunityBloc>();
    UserBloc userBloc = context.watch<UserBloc>();

    bool joined = communityBloc.state.communities[index].joined;
    Photo? community = communityBloc.state.communities[index].photo;

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
              "${community.urls.regular}",
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

          // Name
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Group Name",
                style: GoogleFonts.robotoCondensed(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          /* small description */
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "A small description of the type of groupCard/community",
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
              onPressed: () => _onPressedHandler(joined, communityBloc, userBloc),
              icon: Icon(joined ? Icons.add_box_rounded : Icons.add_box_outlined,
                  color: Colors.white),
              label: Text(joined ? "Joined" : "Join",
                  style: GoogleFonts.roboto(color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }

  void _onPressedHandler(bool joined, CommunityBloc communityBloc, UserBloc userBloc) {
    if (joined) {
      communityBloc.add(DisjoinCommunity(community: communityBloc.state.communities[index]));
    } else {
      communityBloc.add(JoinCommunity(community: communityBloc.state.communities[index]));
    }
  }
}
