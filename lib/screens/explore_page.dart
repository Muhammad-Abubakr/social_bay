/* This Screen Uses Geolocation of a User and matches people and group with similar interests showing them in their feed and  */
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_bay/screens/events_page.dart';
import 'package:social_bay/screens/interests_page.dart';

import '../state/bloc/location_bloc.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final List<Widget> tabs = [const InterestsPage(), const EventsPage()];

  @override
  Widget build(BuildContext context) {
    LocationState state = context.watch<LocationBloc>().state;
    Placemark? placemark = state.placemark?.first;

    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.location_on_rounded),
          leadingWidth: Theme.of(context).iconTheme.size,
          title: Text(
            '${placemark?.locality ?? 'City'}, ${placemark?.country ?? 'Country'}',
            style: GoogleFonts.notoSans(),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.interests_rounded)),
              Tab(icon: Icon(Icons.event_rounded)),
            ],
          ),
        ),
        body: TabBarView(children: tabs),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => {BlocProvider.of<LocationBloc>(context).add(FetchUserLocation())},
          icon: const Icon(Icons.location_searching_rounded),
          label: const Text('recallibrate'),
        ),
      ),
    );
  }
}
