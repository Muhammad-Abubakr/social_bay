import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_bay/state/bloc/user_bloc.dart';
import 'package:unsplash_client/unsplash_client.dart';

class InterestCard extends StatefulWidget {
  final Photo photo;

  const InterestCard(this.photo, {super.key});

  @override
  State<InterestCard> createState() => _InterestCardState();
}

class _InterestCardState extends State<InterestCard> {
  bool joined = false;

  @override
  Widget build(BuildContext context) {
    UserBloc userBloc = context.watch<UserBloc>();

    _handleJoin() {
      if (joined) {
        // userBloc.add(RemoveCommunity(widget.community));
      } else {
        // userBloc.add(UpdateCommunity(widget.community));
      }

      setState(() {
        joined = !joined;
      });
    }

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
              "${widget.photo.urls.regular}",
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
                "A small description of the type of InterestCard/community",
                style: GoogleFonts.robotoCondensed(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          /* Join Button */
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text('Member Count: ${widget.photo.likes}',
                  style: GoogleFonts.roboto(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
