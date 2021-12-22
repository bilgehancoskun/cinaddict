import 'package:cinaddict/models/user.dart';
import 'package:cinaddict/services/firestore.dart';
import 'package:cinaddict/utils/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cinaddict/utils/colors.dart';
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
        backgroundColor: AppColors.alternativeRed,
        automaticallyImplyLeading: false,
        leading:  Image(
          image: AssetImage('lib/assets/cinaddict_logo.png',
          ),
        ),
        title: Text('@bilgehancoskun',
            style: TextStyle(color: Colors.white, fontSize: 18, fontStyle: FontStyle.italic),
        ),
        actions: [
          SizedBox(
            width: 35,
            child: IconButton(icon:Icon(Icons.account_circle_rounded , color: Colors.orangeAccent[300] ),
              onPressed: (){},

            ),
          ),

          SizedBox(
            child: IconButton(icon:Icon(Icons.settings, color: Colors.orangeAccent[300]),
              onPressed: (){},
            ),
          ),
        ],

        ),


      );
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


    );
  }
}
