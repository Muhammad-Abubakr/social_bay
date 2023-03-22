import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_bay/state/bloc/community_bloc.dart';
import 'package:social_bay/state/models/community.dart';

class JoinedCommunitiesPage extends StatelessWidget {
  const JoinedCommunitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    CommunityBloc communityBloc = context.watch<CommunityBloc>();
    List<Community> joinedCommunities = communityBloc.getJoinedCommunities;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Joined Communities"),
      ),
      body: joinedCommunities.isEmpty
          ? Center(
              child: Text(
                "Joined Communities will show here.",
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
                    "${joinedCommunities[index].photo.urls.small}",
                    fit: BoxFit.cover,
                  ).image,
                ),
                title: const Text("Group Name"),
                subtitle: Text(
                  joinedCommunities[index].photo.description ??
                      "Member Count: ${joinedCommunities[index].photo.likes}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: TextButton.icon(
                    onPressed: () => communityBloc
                        .add(DisjoinCommunity(community: joinedCommunities[index])),
                    icon: const Icon(Icons.remove_circle),
                    label: const Text("Remove")),
              ),
              itemCount: joinedCommunities.length,
            ),
    );
  }
}
