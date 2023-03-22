import 'package:flutter/material.dart';

class Story extends StatelessWidget {
  final int index;
  final Uri postURI;

  const Story(this.index, this.postURI, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              "$postURI",
              fit: BoxFit.cover,
            ),
          ),
          if (index % 3 == 0)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    maxRadius: 7,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    maxRadius: 5,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
