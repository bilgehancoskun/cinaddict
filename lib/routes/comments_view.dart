import 'package:cinaddict/models/post.dart';
import 'package:cinaddict/models/user.dart';
import 'package:cinaddict/services/firestore.dart';
import 'package:cinaddict/utils/colors.dart';
import 'package:cinaddict/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:cinaddict/models/comment.dart';
import 'package:cinaddict/models/notification.dart' as CN;
import 'package:cinaddict/services/firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentsView extends StatefulWidget {
  const CommentsView({Key? key, required this.post, required this.username})
      : super(key: key);

  final Post post;
  final String username;

  @override
  State<CommentsView> createState() => _CommentsViewState();
}

class _CommentsViewState extends State<CommentsView> {
  final _formKey = GlobalKey<FormState>();
  String commentContent = '';
  late Post post = widget.post;

  Future<List<ImageProvider>> _getComments() async {
    Post? _updatedPost = await AppFirestore.getPost(post);
    if (_updatedPost != null) {
      post = _updatedPost;
    }
    List<ImageProvider> profilePictures = [];
    for (Comment comment in post.comments) {
      User user = await AppFirestore.getUser(comment.writtenBy);
      profilePictures.add(await AppFirestore.getProfilePictureFromName(
          user.username, user.profilePicture));
    }
    return profilePictures;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Comments'),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context, post);
            },
            icon: Icon(
              Icons.arrow_back,
            ),
          ),
        ),
        body: FutureBuilder(
          future: _getComments(),
          builder: (BuildContext context,
              AsyncSnapshot<List<ImageProvider>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<ImageProvider> profilePictures = snapshot.data!;
              return Stack(
                children: [
                  SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    child: Column(
                      children: [
                        for (int idx = 0;
                            idx < profilePictures.length;
                            idx++) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    backgroundColor: AppColors.lightestGrey,
                                    backgroundImage: profilePictures[idx],
                                    radius: 24,
                                  ),
                                ),
                              ),
                              Expanded(
                                //flex: 4,
                                child: RichText(
                                  text: TextSpan(text: '', children: <TextSpan>[
                                    TextSpan(
                                      text: '${post.comments[idx].writtenBy}: ',
                                      style: AppTextStyle.lightestboldTextStyle,
                                    ),
                                    TextSpan(
                                        text:
                                            ' ${post.comments[idx].content}  ',
                                        style: AppTextStyle.lighterTextStyle),
                                    TextSpan(
                                        text:
                                            '- ${timeago.format(post.comments[idx].timestamp)} ',
                                        style:
                                            AppTextStyle.lightersmallTextStyle),
                                  ]),
                                ),
                              ),
                            ],
                          ),
                        ],
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Form(
                      key: _formKey,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              height: 48.0,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  fillColor: AppColors.darkGrey,
                                  filled: true,
                                  hintText: 'Your comment...',
                                  hintStyle: AppTextStyle.lightTextStyle,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.midGrey,
                                      width: 2.0,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(0)),
                                  ),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(
                                  color: AppColors.white,
                                ),
                                onSaved: (value) {
                                  if (value != null) commentContent = value;
                                },
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () async {
                                _formKey.currentState!.save();
                                Comment comment = Comment(
                                  commentContent,
                                  DateTime.now(),
                                  widget.username,
                                );
                                post.comments.add(comment);
                                await AppFirestore.updatePost(post);
                                if (post.owner != widget.username) {
                                  bool result = await AppFirestore.notify(
                                      who: widget.username,
                                      notificationType:
                                          CN.NotificationType.commentedOnPost,
                                      post: post,
                                      user: post.owner);
                                }
                                setState(() {});
                              },
                              icon: Icon(
                                Icons.done,
                                color: AppColors.white,
                              ))
                        ],
                      ),
                    ),
                  )
                ],
              );
            }

            return Center(
              child: SpinKitFadingCircle(
                color: AppColors.white,
                size: 50,
              ),
            );
          },
        ));
  }
}
