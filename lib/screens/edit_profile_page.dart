import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../state/bloc/user_bloc.dart';
import '../state/models/user.dart' as user;

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, required this.userBloc});

  final UserBloc userBloc;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  XFile? userPicture;

  @override
  void initState() {
    super.initState();

    userPicture = widget.userBloc.state.currentUser!.userPic;
  }

  @override
  Widget build(BuildContext context) {
    final username = TextEditingController(text: widget.userBloc.state.currentUser!.username);
    final bio = TextEditingController(text: widget.userBloc.state.currentUser!.bio);

    void pickImage() async {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedImage == null) return;

      setState(() => userPicture = pickedImage);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 20,
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () => pickImage(),
              child: userPicture == null
                  ? const CircleAvatar(
                      radius: 48,
                      child: Icon(
                        Icons.person,
                        size: 48,
                      ))
                  : CircleAvatar(
                      radius: 48,
                      backgroundImage: FileImage(File(userPicture!.path)),
                    ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: username,
              decoration: const InputDecoration(
                label: Text("Username"),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
              ),
            ),
            TextFormField(
              controller: bio,
              decoration: const InputDecoration(
                label: Text("Bio"),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _handleSave(widget.userBloc, bio, username, userPicture, context),
        child: const Icon(Icons.save),
      ),
    );
  }

  void _handleSave(UserBloc userBloc, TextEditingController bio,
      TextEditingController username, XFile? userPic, BuildContext context) {
    userBloc.add(UpdateUser(
      user.User(
        id: userBloc.state.currentUser!.id,
        bio: bio.text,
        username: username.text,
        userPic: userPic,
      ),
    ));

    Navigator.of(context).pop();
  }
}
