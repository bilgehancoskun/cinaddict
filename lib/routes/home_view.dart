import 'package:cinaddict/models/post.dart';
import 'package:cinaddict/models/user.dart';
import 'package:cinaddict/services/firestore.dart';
import 'package:cinaddict/utils/colors.dart';
import 'package:cinaddict/utils/shared_preferences.dart';
import 'package:cinaddict/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  List<Image> postImages = [];
  List<Post> posts = [];
  late User user = widget.user;


  @override
  void initState() {
    super.initState();
    _futureJobs();
  }


  Future<void> _futureJobs() async {
    await _getUser();
    await getPosts();
    _getPostImages();
  }

  Future<void> _getPostImages() async {
    List<Image> _postImages = [];
    for (Post post in posts) {
      _postImages.add(
          await AppFirestore.getPostImageFromName(post.owner!, post.image!));
      setState(() {
        postImages = _postImages;
      });
    }
  }

  Future<void> getPosts() async {
    List<Post> _posts = [];
    List<User> followingUsers = await AppFirestore.getPostsFollowing(user);
    for (User _user in followingUsers) {
      _posts.addAll(_user.posts);
    }
    _posts.sort((a, b) => a.timestamp!.compareTo(b.timestamp!));

    setState(() {
      posts = List.from(_posts.reversed);
    });
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
            children: [
              for (int idx = 0; idx < posts.length; idx++)
                Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: CircleAvatar(
                            child: ClipOval(
                                child: Image.asset(
                                    "lib/assets/cinaddict_logo.png")),
                            radius: 25,
                          ),
                        ),
                        Text(
                          posts[idx].owner ?? 'no-owner', // post.owner
                          style: AppTextStyle.lighterTextStyle,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    if (idx < postImages.length)
                      postImages[idx]
                    else
                      SizedBox(
                        width: 400,
                        height: 400,
                        child: Container(
                          color: AppColors.darkGrey,
                        ),
                      ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              '@${posts[idx].owner ?? 'no-owner'}', // post.owner
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            if (posts[idx].description!.length < 23)
                              Text(
                                '  ${posts[idx].description}',
                                style: TextStyle(
                                  color: AppColors.white,
                                ),
                              )
                            else
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      '${posts[idx].description!.substring(0, 23)}...',
                                      style: TextStyle(
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              timeago.format(posts[idx].timestamp!),
                              style: TextStyle(color: AppColors.white),
                            ),
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
                ),
            ],
          ),
        ),
      ),
    );
  }
}
