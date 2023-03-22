/* Core Imports */
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/* Third Party */
import 'package:google_fonts/google_fonts.dart';

/* Local Imports */
import 'screens/chat_page.dart';
import 'screens/explore_page.dart';
import 'screens/home_page.dart';
import 'screens/profile_page.dart';
import 'state/bloc/user_bloc.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _curIdx = 0;

  final pages = <Widget>[
    const HomePage(),
    const ExplorePage(),
    const ChatPage(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* Bar */
      appBar: AppBar(
        elevation: 0,
        title: Text('Social Bay', style: GoogleFonts.lobster()),
        centerTitle: true,
      ),

      /* Main Body */
      body: pages[_curIdx],

      /* Bottom Nav Bar */
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => setState(() {
          _curIdx = value;
        }),
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        selectedFontSize: 12.0,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: "Explore",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: "Chats",
          ),
          BottomNavigationBarItem(
            icon: Builder(builder: (context) {
              UserState userState = context.watch<UserBloc>().state;

              return userState.currentUser?.userPic != null
                  ? CircleAvatar(
                      backgroundImage: FileImage(File(userState.currentUser!.userPic!.path)))
                  : const CircleAvatar(
                      child: Icon(Icons.person),
                    );
            }),
            label: "Profile",
          ),
        ],
        currentIndex: _curIdx,
        unselectedItemColor: Colors.black54,
        selectedItemColor: Colors.blueAccent.shade200,
      ),
    );
  }
}
