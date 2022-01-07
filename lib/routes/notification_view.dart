import 'package:cinaddict/models/user.dart';
import 'package:cinaddict/routes/follow_requests.view.dart';
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

  @override
  void initState() {
    super.initState();
    _futureJobs();
  }

  void _futureJobs() async {
    User _user = await AppFirestore.getUser(user.username);
    setState(() {
      user = _user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Notification Page'),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 12.0, 0, 10.0),
                    child: CircleAvatar(
                      child: ClipOval(
                          child: Image.asset("lib/assets/cinaddict_logo.png")),
                      radius: 24,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FollowRequests()));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(7.0, 0.0, 0, 0.0),
                          child: Text(
                            "Follow Requests",
                            style: AppTextStyle.lighterbiggerboldTextStyle,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0, 0.0),
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

              for (CN.Notification notification
                  in user.notifications) ...[
                if (notification.notificationType ==
                    CN.NotificationType.followed) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            child: ClipOval(
                                child: Image.network(
                                    'https://www.linkpicture.com/q/IMG_4207.jpg',
                                    fit: BoxFit.cover)),
                            radius: 24,
                          ),
                        ),
                      ),
                      Expanded(
                        //flex: 4,
                        child: Text(
                          "${notification.user.username} started following you.\n${timeago.format(notification.timestamp)}",
                          style: AppTextStyle.lighterTextStyle,
                        ),
                      ),
                      SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OutlinedButton(
                            onPressed: () {},
                            child: Text(
                              "Follow",
                              style: AppTextStyle.darksmallerTextStyle,
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  AppColors.lightestGrey),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                if (notification.notificationType ==
                    CN.NotificationType.followRequest) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            child: ClipOval(
                                child: Image.network(
                                    'https://www.linkpicture.com/q/IMG_4207.jpg',
                                    fit: BoxFit.cover)),
                            radius: 24,
                          ),
                        ),
                      ),
                      Expanded(
                        //flex: 4,
                        child: Text(
                          "peter_williams sent you a following request.",
                          style: AppTextStyle.lighterTextStyle,
                        ),
                      ),
                      SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OutlinedButton(
                            onPressed: () {},
                            child: Text(
                              "Confirm",
                              style: AppTextStyle.darksmallerTextStyle,
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  AppColors.lightestGrey),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OutlinedButton(
                            onPressed: () {},
                            child: Text(
                              "Delete",
                              style: AppTextStyle.darksmallerTextStyle,
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  AppColors.lightestGrey),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                if (notification.notificationType ==
                    CN.NotificationType.commentedOnPost) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            child: ClipOval(
                                child: Image.network(
                                    'https://www.linkpicture.com/q/IMG_4207.jpg',
                                    fit: BoxFit.cover)),
                            radius: 24,
                          ),
                        ),
                      ),
                      Expanded(
                        //flex: 4,
                        child: Text(
                          "bilgehan.coskun has commented on your post.",
                          style: AppTextStyle.lighterTextStyle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 45,
                          width: 45,
                          child: Container(
                            padding: const EdgeInsets.all(0),
                            child: Image.network(
                                'https://www.linkpicture.com/q/IMG_2031-2_1.jpg',
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],

              //----------------
            ],
          ),
        ));
  }
}
