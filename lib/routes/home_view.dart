import 'package:cinaddict/models/post.dart';
import 'package:cinaddict/models/user.dart';
import 'package:cinaddict/routes/comments_view.dart';
import 'package:cinaddict/routes/profile_view.dart';
import 'package:cinaddict/services/firestore.dart';
import 'package:cinaddict/utils/colors.dart';
import 'package:cinaddict/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:cinaddict/models/notification.dart' as CN;

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  List<Widget> feed = [];
  List<Image> postImages = [];
  List<ImageProvider> profilePicturesOfPosts = [];
  List<Post> posts = [];
  List<bool> likes = [];

  List<bool> founds = [];
  List<bool> founds_dislike = [];
  late User user = widget.user;
  bool noPosts = false;

  @override
  void initState() {
    super.initState();
    _futureJobs();
  }

  Future<void> _getProfilePicturesOfPosts() async {
    List<ImageProvider> _profilePicturesOfPosts = [];
    for (Post post in posts) {
      User user = await AppFirestore.getUser(post.owner);
      ImageProvider profilePicture =
          await AppFirestore.getProfilePictureFromName(
              user.username, user.profilePicture);
      _profilePicturesOfPosts.add(profilePicture);
      setState(() {
        profilePicturesOfPosts = _profilePicturesOfPosts;
      });
    }
  }

  Future<void> _futureJobs() async {
    await _getUser();
    await getPosts();
    _getProfilePicturesOfPosts();
    _getPostImages();
  }

  Future<void> _getPostImages() async {
    List<Image> _postImages = [];
    for (Post post in posts) {
      _postImages
          .add(await AppFirestore.getPostImageFromName(post.owner, post.image));
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
    if (_posts.length == 0) {
      setState(() {
        noPosts = true;
      });
    } else {
      for (int a = 0; a < _posts.length; a++) {
        founds.add(false);
        founds_dislike.add(false);
      }
      _posts.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      setState(() {
        posts = List.from(_posts.reversed);
      });
      for (int x = 0; x < posts.length; x++) {
        for (int i = 0; i < posts[x].like.length; i++) {
          if (posts[x].like[i] == user.username) {
            founds[x] = true;
          }
        }
      }

      for (int x = 0; x < posts.length; x++) {
        for (int i = 0; i < posts[x].dislike.length; i++) {
          if (posts[x].dislike[i] == user.username) {
            founds_dislike[x] = true;
          }
        }
      }
    }
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
      body: RefreshIndicator(
        onRefresh: () async {
          await _futureJobs();
        },
        child: SingleChildScrollView(
          physics:
              AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                if (noPosts)
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'There is no posts to show.',
                          style:
                              TextStyle(color: AppColors.white, fontSize: 18),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.hide_image_outlined,
                            color: AppColors.white,
                            size: 36,
                          ),
                        )
                      ],
                    ),
                  ),
                for (int idx = 0; idx < posts.length; idx++)
                  Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: CircleAvatar(
                              backgroundColor: AppColors.darkGrey,
                              backgroundImage:
                                  idx < profilePicturesOfPosts.length
                                      ? profilePicturesOfPosts[idx]
                                      : null,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                posts[idx].owner, // post.owner
                                style: AppTextStyle.lighterTextStyle,
                              ),
                              if (posts[idx].reSharedFrom != "None")
                                TextButton(
                                    onPressed: () async {
                                      bool viewOnly = true;
                                      if (posts[idx].reSharedFrom == user.username)
                                        viewOnly = false;
                                      User reSharedUser = await AppFirestore.getUser(
                                          posts[idx].reSharedFrom);
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) =>
                                              ProfileView(user: reSharedUser,
                                                viewOnly: viewOnly,
                                                sentBy: user.username,)));
                                    },
                                    child: Text('reshared from ${posts[idx].reSharedFrom}'))
                            ],
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.thumb_up_sharp,
                                color: founds[idx] == true
                                    ? Colors.red
                                    : Colors.white,
                              ),
                              onPressed: () async {
                                if (founds_dislike[idx] == false) {
                                  setState(() {
                                    founds[idx] = !founds[idx];
                                    founds[idx] == true
                                        ? posts[idx].like.add(user.username)
                                        : posts[idx].like.remove(user.username);
                                  });
                                } else {
                                  setState(() {
                                    founds[idx] = true;
                                    founds_dislike[idx] = false;
                                    posts[idx].dislike.remove(user.username);
                                    posts[idx].like.add(user.username);
                                  });
                                }

                                bool result =
                                    await AppFirestore.updatePost(posts[idx]);
                                result = await AppFirestore.notify(
                                    who: user.username,
                                    notificationType: CN.NotificationType.likedPost,
                                    post: posts[idx],
                                    user: posts[idx].owner);
                              },
                            ),
                            Text(
                              '${posts[idx].like.length}',
                              style: AppTextStyle.lighterTextStyle,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.thumb_down_sharp,
                                color: founds_dislike[idx]
                                    ? Colors.red
                                    : Colors.white,
                              ),
                              onPressed: () async {
                                if (founds[idx] == false) {
                                  setState(() {
                                    founds_dislike[idx] = !founds_dislike[idx];
                                    founds_dislike[idx] == true
                                        ? posts[idx].dislike.add(user.username)
                                        : posts[idx]
                                            .dislike
                                            .remove(user.username);
                                  });
                                } else {
                                  setState(() {
                                    founds[idx] = false;
                                    founds_dislike[idx] = true;
                                    posts[idx].like.remove(user.username);
                                    posts[idx].dislike.add(user.username);
                                  });
                                }

                                bool result =
                                    await AppFirestore.updatePost(posts[idx]);
                              },
                            ),
                            Text(
                              '${posts[idx].dislike.length}',
                              style: AppTextStyle.lighterTextStyle,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            IconButton(
                              onPressed: () async {
                                Post? _post = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CommentsView(
                                              post: posts[idx],
                                              username: user.username,
                                            ))) as Post?;
                                if (_post != null) {
                                  setState(() {
                                    posts[idx] = _post;
                                  });
                                }
                              },
                              icon: Icon(
                                Icons.comment,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '${posts[idx].comments.length}',
                              style: AppTextStyle.lighterTextStyle,
                            ),
                            IconButton(
                                onPressed: () async {
                                  Post _reShareThisPost = posts[idx];
                                  _reShareThisPost.reSharedFrom =
                                      posts[idx].owner;
                                  _reShareThisPost.owner = user.username;
                                  _reShareThisPost.timestamp = DateTime.now();
                                  _reShareThisPost.comments = [];
                                  _reShareThisPost.like = [];
                                  _reShareThisPost.dislike = [];
                                  await AppFirestore.uploadPostImageForReShare(
                                      reSharedFrom:
                                          _reShareThisPost.reSharedFrom,
                                      username: _reShareThisPost.owner,
                                      imageName: _reShareThisPost.image);
                                  bool result = await AppFirestore.addPost(
                                      user.username, _reShareThisPost);
                                  if (result) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      backgroundColor: AppColors.yellow,
                                      content: Row(
                                        children: [
                                          Text(
                                            'Post shared successfully!',
                                            style: TextStyle(
                                              color: AppColors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ));
                                  }
                                },
                                icon:
                                    Icon(Icons.repeat, color: AppColors.white)),
                            Spacer(),
                            IconButton(
                              onPressed: () async {
                                await AppFirestore.reportPost(
                                    reportedBy: user.username,
                                    post: posts[idx]);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        backgroundColor: AppColors.white,
                                        content: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Successfully reported post.',
                                              style: TextStyle(
                                                  color: AppColors.black),
                                            )
                                          ],
                                        )));
                              },
                              icon: Icon(
                                Icons.report,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                '@${posts[idx].owner}', // post.owner
                                style: TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              if (posts[idx].description.length < 23)
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
                                        '${posts[idx].description.substring(0, 23)}...',
                                        style: TextStyle(
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                timeago.format(posts[idx].timestamp),
                                style: TextStyle(color: AppColors.white),
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          TextButton(
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero),
                              onPressed: () async {
                                Post? _post = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CommentsView(
                                              post: posts[idx],
                                              username: user.username,
                                            ))) as Post?;
                                if (_post != null) {
                                  setState(() {
                                    posts[idx] = _post;
                                  });
                                }
                              },
                              child: Text(
                                'View all ${posts[idx].comments.length} comments',
                                style: TextStyle(color: AppColors.lighterGrey),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 4,
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
      ),
    );
  }
}
