import 'package:flutter/material.dart';

import '../screens/conversation_page.dart';
import '../state/models/follower.dart';

class PrivateChat extends StatelessWidget {
  final Follower following;

  const PrivateChat(this.following, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: Image.network("${following.photo.user.profileImage.medium}").image,
      ),
      title: Text("${following.photo.user.firstName} ${following.photo.user.lastName ?? ""}"),
      subtitle: const Text("This is the last text message from me or this person."),
      trailing: Text(DateTime.now().toString().split(',')[0].split(' ')[1].split('.')[0]),

      /* Navigate To Conversation Page */
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ConvoPage(),
        ),
      ),

      /* Styling */
      splashColor: Colors.grey.shade200,
    );
  }
}
