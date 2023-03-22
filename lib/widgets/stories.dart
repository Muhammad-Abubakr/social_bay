import 'package:flutter/material.dart';
import 'package:unsplash_client/unsplash_client.dart';

import 'add_story.dart';
import 'story.dart';

class Stories extends StatelessWidget {
  final List<Photo>? photos;

  const Stories(this.photos, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.2,
          height: MediaQuery.of(context).size.longestSide * 0.1,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: AddStory(),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.longestSide * 0.1,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(6.0),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const Divider(indent: 10),
            itemBuilder: (context, index) => Story(index, photos![index].urls.thumb),
            itemCount: photos!.length,
          ),
        ),
      ],
    );
  }
}
