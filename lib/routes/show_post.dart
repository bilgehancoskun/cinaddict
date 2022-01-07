import 'package:cinaddict/models/post.dart';
import 'package:cinaddict/models/user.dart';
import 'package:cinaddict/utils/colors.dart';
import 'package:cinaddict/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:cinaddict/services/firestore.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:cinaddict/routes/comments_view.dart';

class ShowPost extends StatefulWidget {
  const ShowPost({Key? key, required this.post, required this.postImage, required this.user, required this.profilePicture, required this.sentBy}) : super(key: key);

  final Post post;
  final Image postImage;
  final User user;
  final User? sentBy;
  final ImageProvider? profilePicture;

  @override
  State<ShowPost> createState() => _ShowPostState();
}

class _ShowPostState extends State<ShowPost> {

  late int commentsLength = widget.post.comments.length;

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: CircleAvatar(
                        backgroundImage: widget.profilePicture,
                        backgroundColor: AppColors.lightestGrey,
                      ),
                    ),
                    Text(
                      widget.post.owner, // post.owner
                      style: AppTextStyle.lighterTextStyle,
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () async {
                      bool result = await AppFirestore.deletePost(widget.post);
                      if (result) {
                        Navigator.pop(context);
                      }
                    },
                    icon: Icon(Icons.delete, color: AppColors.white,)
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            widget.postImage,
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
                      widget.post.like.add(widget.user.username);
                      bool result = await AppFirestore.updatePost(widget.post);
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
                      widget.post.dislike.add(widget.user.username);
                      bool result = await AppFirestore.updatePost(widget.post);
                    },
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  IconButton(
                    onPressed: () async {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CommentsView(post: widget.post, username: widget.sentBy != null ? widget.sentBy!.username: widget.user.username,)));
                    },
                    icon: Icon(
                      Icons.comment,
                      color: Colors.white,
                    ),
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
                      '@${widget.post.owner}', // post.owner
                      style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    if (widget.post.description.length < 23)
                      Text(
                        '  ${widget.post.description}',
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
                              '${widget.post.description.substring(0, 23)}...',
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
                      timeago.format(widget.post.timestamp),
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
                    onPressed: () async {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CommentsView(post: widget.post, username: widget.sentBy != null ? widget.sentBy!.username: widget.user.username,)));
                      },
                    child: Text(
                      'View all ${widget.post.comments.length} comments',
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
