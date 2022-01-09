import 'package:cinaddict/models/user.dart';
import 'package:cinaddict/services/firestore.dart';
import 'package:cinaddict/utils/colors.dart';
import 'package:cinaddict/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ListFollowers extends StatefulWidget {
  const ListFollowers({Key? key,required this.user}) : super(key: key);

  final User user;

  @override
  _ListFollowersState createState() => _ListFollowersState();
}

class _ListFollowersState extends State<ListFollowers> {
  late User user=widget.user;
  List<ImageProvider> profilePictures=[];

  void _futureJobs() async {
    User _user = await AppFirestore.getUser(user.username);
    setState(() {
      user = _user;
    });
  }

  Future<List<User>> _getFollowers() async {
    List<User> followers = [];
    for (String username in user.followers) {
      User user = await AppFirestore.getUser(username);
      followers.add(user);
    }
    return followers;
  }

  Future<List<ImageProvider>> _getProfilePictures() async {
    List<ImageProvider> _profilePictures=[];
    for (String username in user.followers) {
      User user = await AppFirestore.getUser(username);
      _profilePictures.add(await AppFirestore.getProfilePictureFromName(
          user.username, user.profilePicture));
    }
    setState(() {
      profilePictures=_profilePictures;
    });
    return profilePictures;
  }

  @override
  void initState() {
    super.initState();
    _futureJobs();
    _getProfilePictures();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Followers',
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _getFollowers(),
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            List<User> followers = snapshot.data!;
            return Column(
              children: [
                for(int idx = 0; idx < user.followers.length; idx++)...[
                  SizedBox(height: 16,),
                SingleChildScrollView(
                  child: Row(
                    children: [
                        Row(
                          children: [
                            if(followers[idx].profilePicture == '')
                              SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: CircleAvatar(
                                    radius: 24,
                                    backgroundColor: AppColors.lightestGrey,
                                    backgroundImage: idx < profilePictures.length ? profilePictures[idx]:null,
                                  ),
                                ),
                              )
                            else
                              SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: CircleAvatar(
                                    backgroundColor: AppColors.lightestGrey,
                                    backgroundImage: idx < profilePictures.length ? profilePictures[idx]:null,
                                    radius: 24,
                                  ),
                                ),
                              ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Text(
                                    '${followers[idx].username}',
                                    style: AppTextStyle.whiteTextStyle,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Text(
                                    '${followers[idx].description}',
                                    style: AppTextStyle.whiteTextStyle,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                        OutlinedButton(
                          onPressed: () async {
                            if (!followers[idx].followers.contains(user.username)) {
                              bool result = await AppFirestore.followUser(user.username,followers[idx].username);
                              if (result) {
                                setState(() {
                                  followers[idx].followers.add(user.username);
                                  user.following.add(followers[idx].username);
                                });
                              }
                            }
                            else {
                              bool result = await AppFirestore.unfollowUser(user.username, followers[idx].username);
                              if (result) {
                                setState(() {
                                  followers[idx].followers.remove(user.username);
                                  user.following.remove(followers[idx].username);
                                });
                              }
                            }
                          },
                          child: Row(
                            children: [
                              if (!followers[idx].followers.contains(user.username))
                                Text(
                                  "Follow",
                                  style: AppTextStyle.darkTextStyle,
                                )
                              else
                                Row(
                                  children: [
                                    Text(
                                      "Following",
                                      style: AppTextStyle.darkTextStyle,
                                    ),
                                    Icon(Icons.done),
                                  ],
                                ),
                            ],
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(AppColors.white),
                          ),
                        ),
                      if(user.isPrivate)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                          child: OutlinedButton(
                            onPressed: () async {
                              bool result = await AppFirestore.unfollowUser(followers[idx].username, user.username);
                              if (result) {
                                setState(() {
                                  followers[idx].following.remove(user.username);
                                  user.followers.remove(followers[idx].username);
                                });
                              }
                            },
                            child: Row(
                              children: [
                                Icon(Icons.delete),
                              ],
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(AppColors.white),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                ]
              ],
            );
          }

          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.white,
              size: 50,
            ),
          );
        }
      )
    );
  }
}

/*
OutlinedButton(
                        onPressed: () async {
                          bool result = await AppFirestore.unfollowUser(user.username, followers[idx].username);
                          if (result) {
                            setState(() {
                              followers[idx].followers.remove(user.username);
                              user.following.remove(followers[idx].username);
                            });
                          }
                        },
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Following",
                                  style: AppTextStyle.darkTextStyle,
                                ),
                                Icon(Icons.done),
                              ],
                            ),
                          ],
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(AppColors.white),
                        ),
                      ),
 */