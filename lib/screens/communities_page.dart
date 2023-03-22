import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_bay/state/bloc/community_bloc.dart';
import 'package:social_bay/widgets/group_card.dart';

class CommunitiesPage extends StatelessWidget {
  const CommunitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    CommunityState state = context.watch<CommunityBloc>().state;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Communities",
          style: GoogleFonts.lobsterTwo(),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).orientation.index + 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemBuilder: (context, index) => GroupCard(index),
        itemCount: state.communities.length,
      ),
    );
  }
}
