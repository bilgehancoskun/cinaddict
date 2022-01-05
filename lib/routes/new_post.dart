import 'package:cinaddict/models/post.dart';
import 'package:cinaddict/services/firestore.dart';
import 'package:cinaddict/utils/colors.dart';
import 'package:cinaddict/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class NewPost extends StatefulWidget {
  const NewPost({Key? key, required this.username}) : super(key: key);

  final String username;

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  late Widget _image = createIconButtons();
  final _formKey = GlobalKey<FormState>();
  bool _loadingSwitch = false;
  late Post newPost = Post(
      owner: widget.username,
      like: [],
      dislike: [],
      comments: [],
      description: '',
      image: '',
      timestamp: DateTime.now());
  String? imagePath;

  void initState() {
    super.initState();
  }

  Widget createIconButtons() {
    setState(() {
      _loadingSwitch = false;
    });
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    TextButton(
                        onPressed: () async {
                          setState(() {
                            _loadingSwitch = true;
                            _image = LoadingAnimation();
                          });
                          try {
                            var pickedFile = await ImagePicker()
                                .pickImage(source: ImageSource.camera);
                            if (pickedFile != null) {
                              Image image = Image.file(File(pickedFile.path));
                              newPost.image = pickedFile.name;
                              imagePath = pickedFile.path;
                              setState(() {
                                _loadingSwitch = false;
                                _image = image;
                              });
                            } else {
                              setState(() {
                                _image = createIconButtons();
                              });
                            }
                          } catch (error) {
                            setState(() {
                              setState(() {
                                _image = createIconButtons();
                              });
                            });
                          }
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera,
                              color: AppColors.white,
                              size: 50,
                            ),
                            Text(
                              'Take a photo from camera',
                              style: TextStyle(color: AppColors.white),
                            ),
                          ],
                        )),
                  ],
                ),
                Column(
                  children: [
                    TextButton(
                        onPressed: () async {
                          setState(() {
                            _loadingSwitch = true;
                            _image = LoadingAnimation();
                          });
                          try {
                            var pickedFile = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            if (pickedFile != null) {
                              Image image = Image.file(File(pickedFile.path));
                              newPost.image = pickedFile.name;
                              imagePath = pickedFile.path;
                              setState(() {
                                _loadingSwitch = false;
                                _image = image;
                              });
                            } else {
                              setState(() {
                                _image = createIconButtons();
                              });
                            }
                          } catch (error) {
                            setState(() {
                              setState(() {
                                _image = createIconButtons();
                              });
                            });
                          }
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.album,
                              color: Colors.white,
                              size: 50,
                            ),
                            Text(
                              'Select photo from gallery',
                              style: TextStyle(color: AppColors.white),
                            ),
                          ],
                        )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Return image name if succeeded else return 'no-path'
  Future<bool> createPost(String? caption) async {
    newPost.description = caption ?? '';
    newPost.timestamp = DateTime.now();
    if (imagePath != null) {
      await AppFirestore.uploadPostImage(
          username: widget.username,
          path: imagePath!,
          imageName: newPost.image);
      await AppFirestore.addPost(widget.username, newPost);
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Post'),
        actions: [
          TextButton(
              onPressed: () async {
                _formKey.currentState!.save();
              },
              child: Row(
                children: [
                  Text(
                    'Done ',
                    style: TextStyle(color: AppColors.white),
                  ),
                  Icon(
                    Icons.done,
                    color: AppColors.white,
                  )
                ],
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              _image,
              if (!_loadingSwitch)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            style: TextStyle(
                              color: AppColors.white,
                            ),
                            minLines: 3,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              fillColor: AppColors.darkGrey,
                              filled: true,
                              hintText: 'Write a caption...',
                              hintStyle: AppTextStyle.lightTextStyle,
                            ),
                            onSaved: (value) async {
                              setState(() {
                                _loadingSwitch = true;
                                _image = LoadingAnimation();
                              });

                              bool result = await createPost(value);
                              if (!result) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    'Select an image!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: AppColors.white),
                                  ),
                                  backgroundColor: AppColors.primaryRed,
                                ));
                                setState(() {
                                  _image = createIconButtons();
                                });
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    'Post Shared Successfully!',
                                    textAlign: TextAlign.center,
                                  ),
                                  backgroundColor: AppColors.yellow,
                                ));
                                Navigator.pop(context);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
