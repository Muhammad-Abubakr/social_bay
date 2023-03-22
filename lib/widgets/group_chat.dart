import 'package:flutter/material.dart';

import '../screens/conversation_page.dart';
import '../state/models/community.dart';

class GroupChat extends StatelessWidget {
  final Community community;

  const GroupChat(this.community, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: Image.network("${community.photo.urls.small}").image,
      ),
      title: Text(community.photo.user.username),
      subtitle: const Text("username: This is the latest message."),
      trailing: Text(DateTime.now().toString().split(',')[0].split(' ')[1].split('.')[0]),

      /* On Tap */
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
