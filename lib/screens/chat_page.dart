import 'package:flutter/material.dart';

import 'group_chats_page.dart';
import 'private_chats_page.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.person_2)),
              Tab(icon: Icon(Icons.group)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            PrivateChatsPage(),
            GroupChatsPage(),
          ],
        ),
      ),
    );
  }
}
