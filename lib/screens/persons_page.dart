import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_bay/state/bloc/follower_bloc.dart';
import 'package:social_bay/widgets/person_card.dart';

class PersonsPage extends StatelessWidget {
  const PersonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    FollowerState state = context.watch<FollowerBloc>().state;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Persons",
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
        itemBuilder: (context, index) => PersonCard(index),
        itemCount: state.followers.length,
      ),
    );
  }
}
