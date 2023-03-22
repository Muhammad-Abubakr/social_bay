import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({
    super.key,
  });

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  XFile? image;

  @override
  Widget build(BuildContext context) {
    ImagePicker imagePicker = ImagePicker();

    pickImageChoice(BuildContext context) {
      Scaffold.of(context).showBottomSheet(
        backgroundColor: Colors.transparent,
        (context) => Container(
          height: MediaQuery.of(context).size.longestSide * 0.2,
          padding: const EdgeInsets.only(top: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: ListView(
            children: [
              ListTile(
                onTap: () => imagePicker
                    .pickImage(source: ImageSource.camera)
                    .then((value) => setState(() => image = value))
                    .then((value) => Navigator.of(context).pop()),
                leading: const Icon(Icons.camera_alt_rounded),
                title: const Text("Pick using Camera"),
              ),
              const Divider(),
              ListTile(
                onTap: () => imagePicker
                    .pickImage(source: ImageSource.gallery)
                    .then((value) => setState(() => image = value))
                    .then((value) => Navigator.of(context).pop()),
                leading: const Icon(Icons.photo_size_select_actual_rounded),
                title: const Text("Pick using Gallery"),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Post"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              "POST",
              style: GoogleFonts.notoSans(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  label: Text("Title"),
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text("Description"),
                ),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Builder(builder: (context) {
                    return ElevatedButton(
                      onPressed: () => pickImageChoice(context),
                      child: const Text("Pick Image"),
                    );
                  }),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    height: MediaQuery.of(context).size.longestSide * 0.2,
                    width: MediaQuery.of(context).size.longestSide * 0.2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: image != null
                          ? Image.file(File(image!.path))
                          : const Center(
                              child: Text(
                                "Pick an Image to display here.",
                                textAlign: TextAlign.center,
                              ),
                            ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
