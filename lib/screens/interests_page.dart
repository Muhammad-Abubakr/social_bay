import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_bay/widgets/group_card.dart';
import 'package:unsplash_client/unsplash_client.dart';

import '../screens/communities_page.dart';
import '../screens/persons_page.dart';
import '../state/bloc/photos_bloc.dart';
import '../widgets/person_card.dart';

class InterestsPage extends StatelessWidget {
  const InterestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Photo> photos = context.watch<PhotosBloc>().state.photos;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  "Communities",
                  style: GoogleFonts.lobsterTwo(
                    fontSize: 24,
                    color: Colors.grey.shade800,
                  ),
                ),
                subtitle: const Text("of similar intrests"),
                trailing: IconButton(
                  onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: ((context) => const CommunitiesPage()))),
                  icon: const Icon(Icons.arrow_forward_ios_rounded),
                ),
              ),
              const Divider(thickness: 2),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: ListView.separated(
                  separatorBuilder: (context, index) => const VerticalDivider(),
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => GroupCard(index),
                  itemCount: photos.length,
                ),
              ),
              const Divider(thickness: 2),

              /* Persons with similar Intrests */

              ListTile(
                title: Text(
                  "People",
                  style: GoogleFonts.lobsterTwo(
                    fontSize: 24,
                    color: Colors.grey.shade800,
                  ),
                ),
                subtitle: const Text("with similar intrests"),
                trailing: IconButton(
                  onPressed: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: ((context) => const PersonsPage()))),
                  icon: const Icon(Icons.arrow_forward_ios_rounded),
                ),
              ),
              const Divider(thickness: 2),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: ListView.separated(
                  separatorBuilder: (context, index) => const VerticalDivider(),
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => PersonCard(index),
                  itemCount: photos.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
