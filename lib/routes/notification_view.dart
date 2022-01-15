import 'package:cinaddict/models/user.dart';
import 'package:cinaddict/routes/comments_view.dart';
import 'package:cinaddict/routes/follow_requests.view.dart';
import 'package:cinaddict/routes/profile_view.dart';
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

  Future<void> _futureJobs() async {
    User _user = await AppFirestore.getUser(user.username);
    setState(() {
      user = _user;
    });
    await _getProfilePictures();
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
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 12.0, 0, 10.0),
                      child: CircleAvatar(
                        child: ClipOval(
                            child:
                                Image.asset("lib/assets/cinaddict_logo.png")),
                        radius: 24,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FollowRequests(notifications: user.notifications, user: user,)));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(7.0, 0.0, 0, 0.0),
                            child: Text(
                              "Follow Requests",
                              style: AppTextStyle.lighterbiggerboldTextStyle,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 0.0, 0, 0.0),
                            child: Text(
                              "daily_movies + 308 more",
                              style: AppTextStyle.lighterTextStyle,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
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
                      }
                      else if (user.notifications[idx].notificationType ==
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
                      }
                      else if (user.notifications[idx].notificationType ==
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
