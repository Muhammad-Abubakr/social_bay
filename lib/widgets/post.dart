import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unsplash_client/unsplash_client.dart';

class Post extends StatefulWidget {
  final Photo photo;

  const Post(this.photo, {super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  // state
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      // Styling
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        boxShadow: kElevationToShadow[1],
      ),

      /* Child */
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // User Details
          ListTile(
            leading: InkWell(
              onTap: () => {},
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  "${widget.photo.user.profileImage.medium}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(widget.photo.user.name),
            subtitle: Text("${widget.photo.createdAt}"),
            trailing: IconButton(onPressed: () => {}, icon: const Icon(Icons.more_vert)),
          ),

          // Text /  Descriptions
          if (widget.photo.description != null)
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Text(widget.photo.description!, style: GoogleFonts.roboto(fontSize: 14)),
              ),
            ),

          // Image
          Image.network('${widget.photo.urls.regular}'),

          // like comment share
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () => setState(() => isLiked = !isLiked),
                icon: Icon(
                  isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                  color: isLiked ? Theme.of(context).primaryColor : Colors.black54,
                ),
              ),
              IconButton(
                onPressed: () => {},
                icon: const Icon(Icons.comment, color: Colors.black54),
              ),
              IconButton(
                onPressed: () => {},
                icon: const Icon(Icons.share, color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
