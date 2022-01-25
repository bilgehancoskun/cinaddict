import 'package:cinaddict/models/user.dart';
import 'package:cinaddict/routes/comments_view.dart';
import 'package:cinaddict/routes/follow_requests.view.dart';
import 'package:cinaddict/routes/profile_view.dart';
import 'package:cinaddict/routes/show_post.dart';
import 'package:cinaddict/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:cinaddict/utils/styles.dart';
import 'package:cinaddict/utils/colors.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:cinaddict/models/notification.dart' as CN;

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  _NotificationPage createState() => _NotificationPage();
}

class _NotificationPage extends State<NotificationPage> {
  int counter = 0;
  late User user = widget.user;
  List<ImageProvider> profilePictures = [];
  List<CN.Notification> followRequests = [];
  ImageProvider? lastRequestPicture;

  @override
  void initState() {
    super.initState();
    _futureJobs();
  }

  Future<List<ImageProvider>> _getProfilePictures() async {
    List<ImageProvider> _profilePictures = [];
    for (CN.Notification notification in user.notifications) {
      User user = await AppFirestore.getUser(notification.username);
      _profilePictures.add(await AppFirestore.getProfilePictureFromName(
          user.username, user.profilePicture));
    }
    setState(() {
      profilePictures = _profilePictures;
    });
    return profilePictures;
  }

  Future<void> _getFollowRequests() async {
    List<CN.Notification> _followRequests = [];
    for (CN.Notification notification in user.notifications) {
      if (notification.notificationType == CN.NotificationType.followRequest) {
        _followRequests.add(notification);
        setState(() {
          followRequests = _followRequests;
        });
      }
    }
    if (followRequests.isNotEmpty) {
      User _lastUser = await AppFirestore.getUser(followRequests.last.username);
      ImageProvider image = await AppFirestore.getProfilePictureFromName(
          _lastUser.username, _lastUser.profilePicture);
      setState(() {
        lastRequestPicture = image;
      });
    }
  }

  Future<void> _futureJobs() async {
    User _user = await AppFirestore.getUser(user.username);
    _user.notifications = List.of(_user.notifications.reversed);
    setState(() {
      user = _user;
    });
    await _getProfilePictures();
    await _getFollowRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Notifications'),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await _futureJobs();
          },
          child: SingleChildScrollView(
            physics:
                AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            child: Column(
              children: [
                if (followRequests.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.darkGrey,
                          backgroundImage: lastRequestPicture,
                          radius: 30,
                        ),
                        if (followRequests.length != 0)
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FollowRequests(
                                            notifications: user.notifications,
                                            user: user,
                                          )));
                            },
                            child: Text(
                              followRequests.length - 1 != 0
                                  ? "Follow Requests ${followRequests.last.username} + ${followRequests.length - 1}"
                                  : "Follow Request",
                              style: AppTextStyle.lighterbiggerboldTextStyle,
                            ),
                          )
                      ],
                    ),
                  ),

                for (int idx = 0; idx < user.notifications.length; idx++) ...[
                  TextButton(
                    onPressed: () async {
                      if (user.notifications[idx].notificationType ==
                          CN.NotificationType.followed) {
                        User _pushUser = await AppFirestore.getUser(
                            user.notifications[idx].username);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileView(
                                      user: _pushUser,
                                      sentBy: user.username,
                                      viewOnly: true,
                                    )));
                      } else if (user.notifications[idx].notificationType ==
                          CN.NotificationType.commentedOnPost) {
                        User _pushUser = await AppFirestore.getUser(
                            user.notifications[idx].username);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CommentsView(
                                    post: user.notifications[idx].post!,
                                    username: user.username)));
                      } else if (user.notifications[idx].notificationType ==
                          CN.NotificationType.acceptedRequest) {
                        User _pushUser = await AppFirestore.getUser(
                            user.notifications[idx].username);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileView(
                                      user: _pushUser,
                                      sentBy: user.username,
                                      viewOnly: true,
                                    )));
                      } else if (user.notifications[idx].notificationType ==
                          CN.NotificationType.followRequest) {
                        User _pushUser = await AppFirestore.getUser(
                            user.notifications[idx].username);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileView(
                                      user: _pushUser,
                                      sentBy: user.username,
                                      viewOnly: true,
                                    )));
                      } else if (user.notifications[idx].notificationType ==
                          CN.NotificationType.acceptedRequest) {
                        User _pushUser = await AppFirestore.getUser(
                            user.notifications[idx].username);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileView(
                                      user: _pushUser,
                                      sentBy: user.username,
                                      viewOnly: true,
                                    )));
                      } else if (user.notifications[idx].notificationType ==
                          CN.NotificationType.likedPost) {
                        User _pushUser = await AppFirestore.getUser(
                            user.notifications[idx].username);
                        Image postImage =
                            await AppFirestore.getPostImageFromName(
                                user.notifications[idx].post!.owner,
                                user.notifications[idx].post!.image);
                        User targetUser =
                            await AppFirestore.getUser(user.username);
                        ImageProvider profilePictureOfTarget =
                            await AppFirestore.getProfilePictureFromName(
                                targetUser.username, targetUser.profilePicture);
                        if (user.notifications[idx].post != null)
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShowPost(
                                      post: user.notifications[idx].post!,
                                      postImage: postImage,
                                      user: user,
                                      profilePicture: profilePictureOfTarget,
                                      sentBy: user)));
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundImage: idx < profilePictures.length
                                  ? profilePictures[idx]
                                  : null,
                            ),
                          ),
                        ),
                        if (user.notifications[idx].notificationType ==
                            CN.NotificationType.followed) ...[
                          Expanded(
                            //flex: 4,
                            child: Text(
                              "${user.notifications[idx].username} started following you.\n${timeago.format(user.notifications[idx].timestamp)}",
                              style: AppTextStyle.lighterTextStyle,
                            ),
                          ),
                        ],
                        if (user.notifications[idx].notificationType ==
                            CN.NotificationType.commentedOnPost) ...[
                          Expanded(
                            //flex: 4,
                            child: Text(
                              "${user.notifications[idx].username} commented on your post.\n${timeago.format(user.notifications[idx].timestamp)}",
                              style: AppTextStyle.lighterTextStyle,
                            ),
                          ),
                        ],
                        if (user.notifications[idx].notificationType ==
                            CN.NotificationType.followRequest) ...[
                          Expanded(
                            //flex: 4,
                            child: Text(
                              "${user.notifications[idx].username} requested to follow you.\n${timeago.format(user.notifications[idx].timestamp)}",
                              style: AppTextStyle.lighterTextStyle,
                            ),
                          ),
                        ],
                        if (user.notifications[idx].notificationType ==
                            CN.NotificationType.acceptedRequest) ...[
                          Expanded(
                            //flex: 4,
                            child: Text(
                              "${user.notifications[idx].username} accepted your follow request.\n${timeago.format(user.notifications[idx].timestamp)}",
                              style: AppTextStyle.lighterTextStyle,
                            ),
                          ),
                        ],
                        if (user.notifications[idx].notificationType ==
                            CN.NotificationType.likedPost) ...[
                          Expanded(
                            //flex: 4,
                            child: Text(
                              "${user.notifications[idx].username} liked your post.\n${timeago.format(user.notifications[idx].timestamp)}",
                              style: AppTextStyle.lighterTextStyle,
                            ),
                          ),
                        ],
                        SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: TextButton(
                              onPressed: () async {
                                await AppFirestore.deleteNotification(
                                    user.username, user.notifications[idx]);
                                await _futureJobs();
                              },
                              child: Icon(
                                Icons.delete,
                                color: AppColors.lightestGrey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                //----------------
              ],
            ),
          ),
        ));
  }
}
