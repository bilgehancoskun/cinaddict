import 'package:cinaddict/models/user.dart';
import 'package:cinaddict/routes/new_post.dart';
import 'package:cinaddict/services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key, required this.username}) : super(key: key);

  final String username;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: FutureBuilder(
        future: AppFirestore.getUser(widget.username),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              print('Error Occured in Profile View: ${snapshot.error}');
              return Column(
                children: [
                  Text('ERRRRRRRRRRRRRRROR')
                ],
              );
            }

            User user = snapshot.data;

            return Column(
              children: [
                Text("Username: ${user.username}"),
                TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NewPost(username: user.username,)));
                    },
                    child: Text('Add Post')
                )
              ],
            );

          }

          return Center(
            child: SpinKitFadingCircle(
              color: Colors.white,
              size: 50.0,
            )
          );

        },

      )
    );
  }
}
