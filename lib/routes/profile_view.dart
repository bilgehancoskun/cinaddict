import 'package:cinaddict/models/post.dart';
import 'package:cinaddict/routes/List_followers.dart';
import 'package:cinaddict/routes/list_following.dart';
import 'package:cinaddict/routes/new_post.dart';
import 'package:cinaddict/routes/show_post.dart';
import 'package:cinaddict/routes/zoomed_image.dart';
import 'package:cinaddict/utils/shared_preferences.dart';
import 'package:cinaddict/utils/colors.dart';
import 'package:cinaddict/models/user.dart';
import 'package:cinaddict/services/firestore.dart';
import 'package:cinaddict/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cinaddict/models/notification.dart' as CN;

import 'edit_profile_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView(
      {Key? key,
      required this.user,
      this.viewOnly = false,
      this.sentBy = 'None'})
      : super(key: key);

  final User user;
  final bool viewOnly;
  final String sentBy;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late User user = widget.user;
  User? sentBy;
  List<Image> postImages = [];
  ImageProvider? profilePicture;

  Future<void> _getUser() async {
    if (widget.sentBy != 'None') {
      User _sentBy = await AppFirestore.getUser(widget.sentBy);
      setState(() {
        sentBy = _sentBy;
      });
    }
    User _user = await AppFirestore.getUser(widget.user.username);
    setState(() {
      user = _user;
    });
  }

  bool findFollowRequest() {
    bool result = false;
    for (CN.Notification notification in user.notifications) {
      print("${notification.username} - ${widget.sentBy}");
      if (notification.notificationType == CN.NotificationType.followRequest &&
          notification.username == widget.sentBy) {
        result = true;
        break;
      }
    }

    return result;
  }

  Future<bool> deleteFollowRequest() async {
    bool result = false;
    for (CN.Notification notification in user.notifications) {
      print("${notification.username} - ${widget.sentBy}");
      if (notification.notificationType == CN.NotificationType.followRequest &&
          notification.username == widget.sentBy) {
        result = await AppFirestore.deleteNotification(user.username, notification);
        user.notifications.remove(notification);
        break;
      }
    }
    return result;
  }

  Future<void> _getPostImages() async {
    List<Image> images = [];
    ImageProvider _profilePicture =
        await AppFirestore.getProfilePictureFromName(
            user.username, user.profilePicture);
    setState(() {
      profilePicture = _profilePicture;
    });
    for (Post post in user.posts.reversed) {
      images.add(
          await AppFirestore.getPostImageFromName(user.username, post.image));
      setState(() {
        postImages = images;
      });
    }
  }

  Widget? get setBody {
    return RefreshIndicator(
      onRefresh: () async {
        await _getUser();
        await _getPostImages();
      },
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 12.0, 0, 12.0),
                  child: GestureDetector(
                    onTap: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ZoomedImage(
                                    profilePicture: profilePicture,
                                  )));
                    },
                    child: CircleAvatar(
                      backgroundColor: AppColors.lightGrey,
                      backgroundImage: profilePicture,
                      radius: 50,
                    ),
                  )),
              Column(
                children: [
                  SizedBox(
                    height: 24.0,
                  ),
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
                                padding:
                                    const EdgeInsets.fromLTRB(0, 8.0, 0, 0)),
                            Text(
                              "Posts",
                              style: AppTextStyle.lighterbiggerTextStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ListFollowers(
                                          user: user,
                                        )));
                          },
                          child: Column(
                            children: [
                              Text(
                                "${user.followers.length}",
                                style: AppTextStyle.whiteTextStyle,
                              ),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 8.0, 0, 0)),
                              Text(
                                "Followers",
                                style: AppTextStyle.lighterbiggerTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ListFollowing(user: user)));
                          },
                          child: Column(
                            children: [
                              Text(
                                "${user.following.length}",
                                style: AppTextStyle.whiteTextStyle,
                              ),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 8.0, 0, 0)),
                              Text(
                                "Following",
                                style: AppTextStyle.lighterbiggerTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      if (widget.viewOnly) ...[
                        OutlinedButton(
                          onPressed: () async {
                            if (!user.followers.contains(widget.sentBy) && !findFollowRequest()) {
                              bool result = await AppFirestore.followUser(
                                  user: widget.sentBy, willFollow: user.username);
                              if (result) {
                                setState(() {
                                  user.followers.add(widget.sentBy);
                                });
                              }
                              else {
                                await _getUser();
                              }
                            }
                            else if (findFollowRequest()) {
                              await deleteFollowRequest();
                              setState(() {});
                            }
                            else {
                              bool result = await AppFirestore.unfollowUser(
                                  widget.sentBy, user.username);
                              if (result) {
                                setState(() {
                                  user.followers.remove(widget.sentBy);
                                });
                              }
                            }
                          },
                          child: Row(
                            children: [
                              if (!user.followers.contains(widget.sentBy) && !findFollowRequest())
                                Text(
                                  "Follow",
                                  style: AppTextStyle.darkTextStyle,
                                )
                              else if (findFollowRequest())
                                Row(
                                  children: [
                                    Text(
                                      "Sent Request",
                                      style: AppTextStyle.darkTextStyle,
                                    ),
                                    Icon(Icons.done),
                                  ],
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
                      ] else ...[
                        TextButton(
                          onPressed: () async {
                            Map<String, dynamic>? data = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditProfile(user: user)))
                                as Map<String, dynamic>?;

                            if (data != null) {
                              for (String key in data.keys) {
                                await AppFirestore.updateUser(
                                    user.username, key, data[key]);
                              }
                              await _futureJobs();
                            }
                          },
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(color: AppColors.black),
                          ),
                          style: TextButton.styleFrom(
                              backgroundColor: AppColors.white),
                        )
                      ]
                    ],
                  ),
                ],
              ),
            ],
          ),
          // Text("Username: ${user.username}"),
          Container(
            // width: 200.0,
            height: 30.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0.0),
            ),
            child: Row(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '   ', //display_name
                  style: AppTextStyle.whiteTextStyle,
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    user.displayName, //display_name
                    style: AppTextStyle.whiteTextStyle,
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
                Text(
                  '   ', //display_name
                  style: AppTextStyle.whiteTextStyle,
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    user.description, //description
                    style: AppTextStyle.lighterTextStyle,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: AppColors.white,
            thickness: 2,
          ),
          if (!widget.viewOnly ||
              !user.isPrivate ||
              user.followers.contains(widget.sentBy)) // add !widget.viewOnly
            GridView.count(
              shrinkWrap: true,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              crossAxisCount: 3,
              physics: NeverScrollableScrollPhysics(),
              children: [
                for (int idx = 0; idx < user.posts.length; idx++)
                  InkWell(
                    onTap: () async {
                      if (sentBy == null) {
                        sentBy = user;
                      }
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShowPost(
                                    sentBy: sentBy!,
                                    post: user.posts.reversed.elementAt(idx),
                                    postImage: postImages[idx],
                                    user: user,
                                    profilePicture: profilePicture,
                                  )));
                      await _futureJobs();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(0),
                      child: idx < postImages.length ? postImages[idx] : null,
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: AppColors.black,
                        width: 1,
                      )),
                    ),
                  ),
              ],
            )
          else
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.lock,
                    color: AppColors.white,
                    size: 36,
                  ),
                ),
                Text(
                  'Account is private',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
        ]),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _futureJobs();
  }

  Future<void> _futureJobs() async {
    await _getUser();
    await _getPostImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Row(
            children: [
              if (widget.viewOnly)
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back)),
              if (!widget.viewOnly)
                Image(
                  image: AssetImage(
                    'lib/assets/cinaddict_logo.png',
                  ),
                ),
            ],
          ),
          title: Text(
            '@${user.username}',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontStyle: FontStyle.italic),
          ),
          actions: [
            if (!widget.viewOnly)
              SizedBox(
                width: 35,
                child: IconButton(
                  icon: Icon(Icons.add, color: Colors.orangeAccent[300]),
                  onPressed: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                NewPost(username: user.username)));
                    _futureJobs();
                  },
                ),
              ),
            if (!widget.viewOnly)
              SizedBox(
                child: IconButton(
                  icon: Icon(Icons.logout, color: Colors.orangeAccent[300]),
                  onPressed: () async {
                    bool result = await AppSharedPreferences.logout();
                    if (result) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/login', ModalRoute.withName('/'));
                    }
                  },
                ),
              ),
          ],
        ),
        body: setBody);
  }
}
