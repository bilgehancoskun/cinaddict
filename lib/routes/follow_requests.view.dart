import 'package:cinaddict/models/user.dart';
import 'package:cinaddict/services/firestore.dart';
import 'package:cinaddict/utils/colors.dart';
import 'package:cinaddict/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:cinaddict/models/notification.dart' as CN;

class FollowRequests extends StatefulWidget {
  const FollowRequests({Key? key, required this.user, required this.notifications}) : super(key: key);
  final List<CN.Notification> notifications;
  final User user;

  @override
  State<FollowRequests> createState() => _FollowRequestsState();
}

class _FollowRequestsState extends State<FollowRequests> {
  List<ImageProvider> profilePictures = [];
  late List<CN.Notification> notifications = widget.notifications;

  Future<void> _getProfilePictures() async {
    List<ImageProvider> _profilePictures = [];
    for (CN.Notification notification in notifications) {
      if (notification.notificationType == CN.NotificationType.followRequest) {
        User user = await AppFirestore.getUser(notification.username);
        _profilePictures.add(
          await AppFirestore.getProfilePictureFromName(user.username, user.profilePicture)
        );
        setState(() {
          profilePictures = _profilePictures;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getProfilePictures();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Follow Requests'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          for (int idx = 0; idx < notifications.length; idx++)
            if(notifications[idx].notificationType == CN.NotificationType.followRequest)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              Row(
                children:[Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: CircleAvatar(
                  backgroundImage: idx < profilePictures.length ? profilePictures[idx]: null,
                  backgroundColor: AppColors.darkGrey,
                ),
              ),
                  Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[ Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(
                            notifications[idx].username, // This should be username
                              style: TextStyle(color: Colors.white),

                          ),
                      ),


                 ] )
                ],),

            Row(
              children:[
                Padding(padding: EdgeInsets.zero,

                    child: SizedBox(
                      height: 25,
                      width: 69,
                      child: OutlinedButton(
                        onPressed: () async {
                          bool result = await AppFirestore.followUser(user: notifications[idx].username, willFollow: widget.user.username, sentFrom: 'FollowRequests');
                          print(result);
                          if (result) {
                            await AppFirestore.deleteNotification(widget.user.username, notifications[idx]);
                            await AppFirestore.notify(who: widget.user.username, notificationType: CN.NotificationType.acceptedRequest, user: notifications[idx].username);
                            setState(() {
                              notifications.removeAt(idx);
                              profilePictures.removeAt(idx);
                            });
                          }
                        },
                        child: Text(
                          "Confirm",
                          style: AppTextStyle.darksmallestTextStyle,
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(AppColors.lightestGrey),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5, width: 5,),
                  SizedBox(
                    height: 25,
                    width: 62,
                    child: OutlinedButton(
                      onPressed: () async {
                        bool result = await AppFirestore.deleteNotification(widget.user.username, notifications[idx]);
                        if (result) {
                          setState(() {
                            notifications.removeAt(idx);
                            profilePictures.removeAt(idx);
                          });
                        }
                      },
                      child: Text(
                        "Delete",
                        style: AppTextStyle.darksmallestTextStyle,
                      ),
                      style: ButtonStyle(

                        backgroundColor: MaterialStateProperty.all(AppColors.lightestGrey),
                      ),
                    ),
                  ),

              ]
            )
            ],
          ),
        ],
      )
    );
  }
}
