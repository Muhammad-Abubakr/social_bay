import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_bay/screens/ifollowing_page.dart';
import 'package:social_bay/screens/joined_communities_page.dart';
import 'package:social_bay/state/bloc/photos_bloc.dart';
import 'package:unsplash_client/unsplash_client.dart';

import '../state/bloc/user_bloc.dart';
import 'create_post_page.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Photo>? photos = context.watch<PhotosBloc>().state.photos;
    final userBloc = context.watch<UserBloc>();
    bool isVertical = MediaQuery.of(context).orientation.index == 0;

    return Scaffold(
      body: Column(
        children: [
          if (isVertical) ...[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: UserPfp(userBloc: userBloc),
            ),
            Username(userBloc.state.currentUser!.username!),
            const SizedBox(height: 5),
            Text(userBloc.state.currentUser!.bio!),
            const Divider(thickness: 1),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Followers"),
                        Text('${userBloc.state.followers.length}'),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const JoinedCommunitiesPage(),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Communities",
                            softWrap: true,
                            textAlign: TextAlign.center,
                          ),
                          Text('${userBloc.state.communities.length}'),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const IFollowingPage(),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Following"),
                          Text('${userBloc.state.following.length}'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 1),
          ],
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
            child: Text("My Posts",
                style: GoogleFonts.lobsterTwo(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isVertical ? 3 : 5,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
              ),
              itemBuilder: (context, index) => Image.network(
                "${photos[index].urls.regular}",
                fit: BoxFit.cover,
              ),
              itemCount: photos.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const CreatePostPage(),
          ),
        ),
        icon: const Icon(Icons.post_add),
        label: const Text("Create Post"),
      ),
    );
  }
}

class Username extends StatelessWidget {
  final String username;

  const Username(
    this.username, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      username,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class UserPfp extends StatelessWidget {
  const UserPfp({super.key, required this.userBloc});
  final UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        userBloc.state.currentUser!.userPic == null
            ? CircleAvatar(
                backgroundColor: Colors.blueGrey.shade100,
                radius: 48,
                child: const Icon(
                  Icons.person,
                  color: Colors.blueGrey,
                  size: 48,
                ),
              )
            : CircleAvatar(
                backgroundImage: FileImage(File(userBloc.state.currentUser!.userPic!.path)),
                radius: 48,
              ),
        InkWell(
          borderRadius: BorderRadius.circular(48),
          child: CircleAvatar(
            radius: 16,
            backgroundColor: Theme.of(context).primaryColor,
            child: const Icon(
              Icons.edit,
              color: Colors.white,
              size: 18,
            ),
          ),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EditProfilePage(userBloc: userBloc),
            ),
          ),
        )
      ],
    );
  }
}
