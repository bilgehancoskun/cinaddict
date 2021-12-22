
import 'package:cinaddict/models/user.dart';
import 'package:cinaddict/services/firestore.dart';
import 'package:cinaddict/utils/colors.dart';
import 'package:cinaddict/utils/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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

            return  Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 12.0, 0, 12.0),
                        child: CircleAvatar(
                          child: ClipOval(
                              child: Image.asset("lib/assets/cinaddict_logo.png")
                          ),
                          radius: 50,
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(height:24.0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "${user.posts.length}",
                                      style: AppTextStyle.whiteTextStyle,
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 8.0, 0,0)
                                    ),
                                    Text(
                                      "Posts",
                                      style: AppTextStyle.lighterbiggerTextStyle,
                                    ),

                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "${user.followers.length}",
                                      style: AppTextStyle.whiteTextStyle,
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 8.0, 0,0)
                                    ),
                                    Text(
                                      "Followers",
                                      style: AppTextStyle.lighterbiggerTextStyle,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "${user.following.length}",
                                      style: AppTextStyle.whiteTextStyle,
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 8.0, 0,0)
                                    ),
                                    Text(
                                      "Following",
                                      style: AppTextStyle.lighterbiggerTextStyle,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              OutlinedButton(
                                onPressed: (){},
                                child: Text(
                                  "Follow",
                                  style: AppTextStyle.darkTextStyle,
                                ),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(AppColors.white),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                              ),
                              OutlinedButton(
                                onPressed: (){},
                                child: Text(
                                  "Message",
                                  style: AppTextStyle.darkTextStyle,
                                ),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(AppColors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                    ],
                  ),

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
