// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:image_picker/image_picker.dart';

class User {
  final String? id;
  final String? username;
  final String? bio;
  final XFile? userPic;

  User({
    this.id,
    this.username,
    this.bio,
    this.userPic,
  });
}
