import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_bay/state/bloc/photos_bloc.dart';
import 'package:unsplash_client/unsplash_client.dart';

import '../widgets/post.dart';
import '../widgets/stories.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Photo>? photos;

  @override
  void didChangeDependencies() {
    photos = context.watch<PhotosBloc>().state.photos;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Stories",
                style: GoogleFonts.lobsterTwo(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          Stories(photos),
          const Divider(color: Colors.black),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Posts",
                style: GoogleFonts.lobsterTwo(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          ...photos!.map((photo) => Post(photo))
        ],
      ),
    );
  }
}
