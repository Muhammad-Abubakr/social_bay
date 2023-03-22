import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddStory extends StatelessWidget {
  const AddStory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    XFile? image;
    ImagePicker imagePicker = ImagePicker();

    pickImageChoice() {
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
                    .then((value) => image = value)
                    .then((value) => Navigator.of(context).pop()),
                leading: const Icon(Icons.camera_alt_rounded),
                title: const Text("Pick using Camera"),
              ),
              const Divider(),
              ListTile(
                onTap: () => imagePicker
                    .pickImage(source: ImageSource.gallery)
                    .then((value) => image = value)
                    .then((value) => Navigator.of(context).pop()),
                leading: const Icon(Icons.photo_size_select_actual_rounded),
                title: const Text("Pick using Gallery"),
              ),
            ],
          ),
        ),
      );
    }

    return InkWell(
      customBorder: const CircleBorder(),
      splashColor: Theme.of(context).primaryColor,
      onTap: () => pickImageChoice(),
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Icon(
          Icons.add_a_photo_sharp,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
