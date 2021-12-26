import 'package:cinaddict/models/post.dart';
import 'package:cinaddict/models/user.dart';
import 'package:cinaddict/services/firestore.dart';
import 'package:cinaddict/utils/colors.dart';
import 'package:cinaddict/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  List<Widget> feed = [];
  late User user = widget.user;
  bool viewDone = false;

  Future<void> getFeed() async {
    await _getUser();
    print(widget.user.following);
    List<User> followingUsers =
        await AppFirestore.getPostsFollowing(widget.user);
    List<Widget> _feed = [];
    for (User _user in followingUsers) {
      for (Post post in _user.posts) {
        Image postImage =
            await AppFirestore.getPostImageFromName(_user.username, post.image!);
          _feed.add(Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: CircleAvatar(
                      child: ClipOval(
                          child: Image.asset("lib/assets/cinaddict_logo.png")),
                      radius: 25,
                    ),
                  ),
                  Text(
                    user.username,
                    style: AppTextStyle.lighterTextStyle,
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              postImage,
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('@${_user.username}', style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold
                      ),),
                      if(post.description!.length < 25)
                      Text('  ${post.description}', style: TextStyle(
                        color: AppColors.white,
                      ),)
                      else
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Text('${post.description!.substring(0, 25)}...', style: TextStyle(
                                color: AppColors.white,
                              ),),
                            ),
                          ],
                        )
                    ],
                  ),
                  Row(
                    children: [
                      Text(timeago.format(post.timestamp!), style: TextStyle(
                        color: AppColors.white
                      ),),
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.thumb_up_sharp,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(
                      Icons.thumb_down_sharp,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(
                      Icons.comment,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(
                      Icons.navigation,
                      color: Colors.white,
                    ),
                    Spacer(),
                    Icon(
                      Icons.bookmark,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Divider(
                color: AppColors.white,
                thickness: 5.0,
              ),
            ],
          ));

      }
    }

    setState(() {
      feed = _feed;
    });
  }

  @override
  void initState() {
    super.initState();
    _futureJobs();
  }

  Future<void> _futureJobs() async {
    await getFeed();
  }

  Future<void> _getUser() async {
    User _user = await AppFirestore.getUser(user.username);
    setState(() {
      user = _user;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: feed,
          ),
        ),
      ),
    );
  }
}
