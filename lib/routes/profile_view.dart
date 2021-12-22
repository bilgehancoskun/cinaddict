//import 'dart:html';

import 'package:cinaddict/models/user.dart';
import 'package:cinaddict/services/firestore.dart';
import 'package:cinaddict/utils/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cinaddict/utils/colors.dart';
import 'package:cinaddict/utils/styles.dart';
import 'package:flutter/src/rendering/box.dart';

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
               // Text("Username: ${user.username}"),
                SizedBox(
                  height: 120,
                ),
                Container(
                // width: 200.0,
                height: 30.0,
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0.0),

                ),
                  child: Row(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('   ',//display_name
                        style:
                        AppTextStyle.whiteTextStyle,
                      ),
                      Expanded(
                        flex: 1,
                        child:Text(
                          'Charles Dickens',//display_name
                          style:
                          AppTextStyle.whiteTextStyle,
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 45.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0.0),
          ),
                  child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('   ',//display_name
                      style:
                      AppTextStyle.whiteTextStyle,

                    ),

                    Expanded(
                      flex: 1,
                      child: Text(
                        'Movie fan/ Part-time blogger',//description
                        style:
                        AppTextStyle.lighterTextStyle,
                      ),
                    ),
                  ],
                  ),
                ),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  crossAxisCount: 3,
                  children: [

                    InkWell(
                      onTap: (){
                        print("sgdhss");
                      },
                      child: Container(
                        padding: const EdgeInsets.all(0),
                        child:   Image.network('https://www.linkpicture.com/q/IMG_2031-2_1.jpg',fit: BoxFit.cover),

                      ),
                    ),

                    InkWell(
                      onTap: (){
                        print("sgdhss");
                      },
                      child: Container(
                        padding: const EdgeInsets.all(0),
                        child:Image.network('https://www.linkpicture.com/q/IMG_2034-2.jpg',fit: BoxFit.cover),

                      ),
                    ),
                    InkWell(
                      onTap: (){
                        print("sgdhss");
                      },
                      child: Container(
                        padding: const EdgeInsets.all(0),
                        child: Image.network('https://www.linkpicture.com/q/IMG_2032-2_1.jpg',fit: BoxFit.cover),

                      ),
                    ),
                    InkWell(
                      onTap: (){
                        print("sgdhss");
                      },
                      child: Container(
                        padding: const EdgeInsets.all(0),
                        child: Image.network('https://www.linkpicture.com/q/IMG_2036-3.jpg',fit: BoxFit.cover),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        print("sgdhss");
                      },
                      child: Container(
                        padding: const EdgeInsets.all(0),
                        child:Image.network('https://www.linkpicture.com/q/IMG_2037-2_1.jpg',fit: BoxFit.cover),
                      ),
                    ),
                  ],

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


    );
  }
}
