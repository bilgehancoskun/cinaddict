import 'package:cinaddict/models/user.dart';
import 'package:cinaddict/utils/colors.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  Map<String, dynamic> data = {};
  late bool isPrivate = widget.user.isPrivate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: AppColors.alternativeRed,
      ),
      body: Column(
        children: [
          TextButton(onPressed: () {
            // User = widget.user
            // Display Name: data['displayName']
            // Username: data['username']
            // Description: data['description']
            // Private Account: data['isPrivate'] -> Bool (Switch ile yap)
            data['name'] = 'Bilgehan';
            Navigator.pop(context, data);
          }, child: Text('Save Changes'))
        ],
      ),
    );
  }
}
