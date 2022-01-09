import 'package:cinaddict/models/user.dart';
import 'package:cinaddict/services/firestore.dart';
import 'package:cinaddict/utils/colors.dart';
import 'package:cinaddict/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class ListFollowing extends StatefulWidget {
  const ListFollowing({Key? key,required this.user}) : super(key: key);

  final User user;

  @override
  _ListFollowingState createState() => _ListFollowingState();
}

class _ListFollowingState extends State<ListFollowing> {
  late User user=widget.user;
  List<ImageProvider> profilePictures=[];

  void _futureJobs() async {
    User _user = await AppFirestore.getUser(user.username);
    setState(() {
      user = _user;
    });
  }

  Future<List<User>> _getFollowing() async {
    List<User> following = [];
    for (String username in user.following) {
      User user = await AppFirestore.getUser(username);
      following.add(user);
    }
    return following;
  }

  Future<List<ImageProvider>> _getProfilePictures() async {
    List<ImageProvider> _profilePictures=[];
    for (String username in user.following) {
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
            'Following',
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: _getFollowing(),
            builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot){
              if(snapshot.connectionState == ConnectionState.done){
                List<User> following = snapshot.data!;
                return Column(
                  children: [
                    for(int idx = 0; idx < user.following.length; idx++)...[
                      SizedBox(height: 16,),
                      SingleChildScrollView(
                        child: Row(
                          children: [
                            Row(
                              children: [
                                if(following[idx].profilePicture == '')
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
                                        '${following[idx].username}',
                                        style: AppTextStyle.whiteTextStyle,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Text(
                                        '${following[idx].description}',
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
                                  bool result = await AppFirestore.unfollowUser(user.username, following[idx].username);
                                  if (result) {
                                    setState(() {
                                      following[idx].followers.remove(user.username);
                                      user.following.remove(following[idx].username);
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
SizedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: CircleAvatar(
                                      backgroundColor: AppColors.lightestGrey,
                                      backgroundImage: profilePictures[idx],
                                      radius: 24,
                                    ),
                                  ),
                                ),
 */