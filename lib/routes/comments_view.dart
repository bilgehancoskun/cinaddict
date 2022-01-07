import 'package:cinaddict/models/post.dart';
import 'package:cinaddict/models/user.dart';
import 'package:cinaddict/services/firestore.dart';
import 'package:cinaddict/utils/colors.dart';
import 'package:cinaddict/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:cinaddict/models/comment.dart';
import 'package:cinaddict/services/firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentsView extends StatefulWidget {
  const CommentsView({Key? key, required this.post, required this.username}) : super(key: key);

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
        ),
        body: FutureBuilder(
          future: _getComments(),
          builder: (BuildContext context,
              AsyncSnapshot<List<ImageProvider>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<ImageProvider> profilePictures = snapshot.data!;
              return Column(
                children: [
                  SingleChildScrollView(
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
                                child: Text(
                                  "${post.comments[idx].writtenBy}: ${post.comments[idx].content} - ${timeago.format(post.comments[idx].timestamp)}",
                                  style: AppTextStyle.lighterTextStyle,
                                ),
                              ),
                            ],
                          ),
                        ]
                      ],
                    ),
                  ),
                  Spacer(),
                  Form(
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
                                if (value != null)
                                  commentContent = value;
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
                              setState(() {});
                            },
                            icon: Icon(Icons.done, color: AppColors.white,))
                      ],
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

/*
SingleChildScrollView(
        child: Column(
          children: [
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
                    "BURASI",
                    style: AppTextStyle.lighterTextStyle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
 */
