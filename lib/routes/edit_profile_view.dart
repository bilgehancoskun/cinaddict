import 'package:cinaddict/models/user.dart';
import 'package:cinaddict/services/firestore.dart';
import 'package:cinaddict/utils/colors.dart';
import 'package:cinaddict/utils/styles.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> data = {};
  late bool isPrivate;
  String? displayName;
  String? description;

  late Widget _image = createIconButtons();
  bool _loadingSwitch = false;
  String? imagePath;
  String? imageName;

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
                            var pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
                            if (pickedFile != null) {
                              Image image = Image.file(File(pickedFile.path));
                              imagePath = pickedFile.path;
                              imageName = pickedFile.name;
                              setState(() {
                                _loadingSwitch = false;
                                _image = image;
                              });
                            }
                            else {
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
                            Icon(Icons.camera, color: AppColors.white, size: 50,),
                            Text('Take a photo from camera', style: TextStyle(
                                color: AppColors.white
                            ),),
                          ],
                        )
                    ),
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
                            var pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                            if (pickedFile != null) {
                              Image image = Image.file(File(pickedFile.path));
                              imagePath = pickedFile.path;
                              imageName = pickedFile.name;
                              setState(() {
                                _loadingSwitch = false;
                                _image = image;
                              });
                            }
                            else {
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
                            Icon(Icons.album, color: Colors.white, size: 50,),
                            Text('Select photo from gallery', style: TextStyle(
                                color: AppColors.white
                            ),),
                          ],
                        )
                    ),
                  ],
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }


  @override
  void initState() {
    isPrivate = widget.user.isPrivate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        actions: [
          SizedBox(
            child: TextButton(
              onPressed: (){
                _loadingSwitch = true;
                _formKey.currentState!.save();
                data["displayName"]=displayName;
                data["description"]=description;
                data["isPrivate"]=isPrivate;
                data["image"] = imageName;
                if (imageName != null && imagePath != null)
                  AppFirestore.uploadProfilePicture(username: widget.user.username, path: imagePath!, imageName: imageName!);
                _loadingSwitch = false;
                Navigator.pop(context, data);
              },
              child: Row(
                children: [
                  Text(
                    "Save Changes ",
                    style: TextStyle(
                      color: AppColors.white,
                    ),
                  ),
                  Icon(Icons.done,color: AppColors.white,)
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            "Change Profile Picture ",
                            style: AppTextStyle.lighterbiggerTextStyle,
                          ),
                          _image,
                        ],
                      ),
                    ),
                    if (!_loadingSwitch)...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Display Name: ",
                          style: AppTextStyle.lighterbiggerTextStyle,
                        ),
                        SizedBox(
                          width: 250,
                          child:TextFormField(
                              decoration: InputDecoration(
                                //fillColor: AppColors.darkGrey,
                                //filled: true,
                                hintText: '${widget.user.displayName}',
                                hintStyle: AppTextStyle.lightTextStyle,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.midGrey,
                                    width: 2.0,
                                  ),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(0)),
                                ),
                              ),
                              keyboardType: TextInputType.text,
                              enableSuggestions: false,
                              autocorrect: false,
                              onSaved: (value){
                                if(value == ''){
                                  displayName=widget.user.displayName;
                                }
                                else{
                                  displayName=value;
                                }
                              },
                            ),
                        ),
                      ],
                    ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Description: ",
                        style: AppTextStyle.lighterbiggerTextStyle,
                      ),
                      SizedBox(
                        width: 250,
                        child: TextFormField(
                          decoration: InputDecoration(
                            //fillColor: AppColors.darkGrey,
                            //filled: true,
                            hintText: '${widget.user.description}',
                            hintStyle: AppTextStyle.lightTextStyle,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.midGrey,
                                width: 2.0,
                              ),
                              borderRadius:
                              BorderRadius.all(Radius.circular(0)),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          enableSuggestions: false,
                          autocorrect: false,
                          onSaved: (value){
                            if(value == ''){
                              description=widget.user.description;
                            }
                            else{
                              description=value;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Text(
                        "Account Status (Private or not): ",
                        style: AppTextStyle.lighterbiggerTextStyle,
                      ),
                      Switch(
                        activeColor: Colors.green,
                        value: isPrivate,
                        onChanged:(value){
                          setState(() {
                            isPrivate=value;
                          });
                        },
                      ),
                    ],
                  ),
                  ]
                ],
              ),
            ),
          ),
      ),
    );
  }
}
// User = widget.user
// Display Name: data['displayName']
// Username: data['username']
// Description: data['description']
// Private Account: data['isPrivate'] -> Bool (Switch ile yap)
//data['name'] = 'Bilgehan';
//Navigator.pop(context, data);
