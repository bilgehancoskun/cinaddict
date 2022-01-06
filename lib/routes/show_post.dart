import 'package:cinaddict/models/post.dart';
import 'package:cinaddict/models/user.dart';
import 'package:cinaddict/utils/colors.dart';
import 'package:cinaddict/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:cinaddict/services/firestore.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:cinaddict/routes/comments_view.dart';

class ShowPost extends StatelessWidget {
  const ShowPost({Key? key, required this.post, required this.postImage, required this.user}) : super(key: key);

  final Post post;
  final Image postImage;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post'),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                  post.owner, // post.owner
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.thumb_up_sharp,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      post.like.add(user.username);
                      bool result = await AppFirestore.updatePost(post);
                    },
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.thumb_down_sharp,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      post.dislike.add(user.username);
                      bool result = await AppFirestore.updatePost(post);
                    },
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      '@${post.owner}', // post.owner
                      style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    if (post.description.length < 23)
                      Text(
                        '  ${post.description}',
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
                              '${post.description.substring(0, 23)}...',
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
                      timeago.format(post.timestamp),
                      style: TextStyle(color: AppColors.white),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                TextButton(
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.zero
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CommentsView(post: post, username: user.username,)));
                    },
                    child: Text(
                      'View all ${post.comments.length} comments',
                      style: TextStyle(
                          color: AppColors.lighterGrey
                      ),
                    )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
