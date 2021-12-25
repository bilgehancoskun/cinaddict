import 'package:cinaddict/models/post.dart';
import 'package:cinaddict/services/firestore.dart';
import 'package:cinaddict/utils/colors.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class NewPost extends StatefulWidget {
  const NewPost({Key? key, required this.username}) : super(key: key);

  final String username;

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  Image _image = Image(image: AssetImage('lib/assets/cinaddict_logo.png'));

  // Return image name if succeeded else return 'no-path'
  Future<String> uploadFromCamera() async {
    var pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      String imageName = pickedFile.name;
      String imagePath = '${widget.username}/posts/$imageName';
      File file = File(pickedFile.path);

      try {
        await FirebaseStorage.instance
            .ref(imagePath)
            .putFile(file);
        return imageName;
      } on FirebaseException catch (e) {
        print("While uploading file error occurred: $e");
        return 'no-image';
      }
    }
    return 'no-image';
  }

  // Return image name if succeeded else return 'no-path'
  Future<String> uploadFromGallery() async {
    var pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      String imageName = pickedFile.name;
      String imagePath = '${widget.username}/posts/$imageName';
      File file = File(pickedFile.path);

      try {
        await FirebaseStorage.instance
            .ref(imagePath)
            .putFile(file);
        return imageName;
      } on FirebaseException catch (e) {
        print("While uploading file error occurred: $e");
        return 'no-image';
      }
    }
    return 'no-image';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Post'),
        backgroundColor: AppColors.primaryRed,
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
                onPressed: () async {
                  String imageName = await uploadFromCamera();
                  Post newPost = Post(imageName, '', 5, 5, []);
                  AppFirestore.addPost(widget.username, newPost);
                  Image image = await AppFirestore.getPostImageFromName(widget.username, imageName);
                  setState(() {
                    _image = image;
                  });
                },
                child: Text('Upload Image From Camera')
            ),
            TextButton(
                onPressed: () async {
                  String imageName = await uploadFromGallery();
                  Post newPost = Post(imageName, '', 5, 5, []);
                  AppFirestore.addPost(widget.username, newPost);
                  Image image = await AppFirestore.getPostImageFromName(widget.username, imageName);
                  setState(() {
                    _image = image;
                  });
                },
                child: Text('Upload Image From Gallery')
            ),
              _image, // Image()
          ],
        ),
      ),
    );
  }
}
