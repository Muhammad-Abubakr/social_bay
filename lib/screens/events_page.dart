import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_bay/state/bloc/photos_bloc.dart';
import 'package:social_bay/widgets/event_tile.dart';
import 'package:unsplash_client/unsplash_client.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    final List<Photo> photos = context.watch<PhotosBloc>().state.photos;

    return ListView.separated(
      itemBuilder: (context, index) => const EventTile(),
      separatorBuilder: (context, index) => const Divider(
        indent: 0,
        endIndent: 0,
        height: 0,
        thickness: 1,
      ),
      itemCount: photos.length,
    );
  }
}
