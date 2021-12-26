import 'package:cinaddict/routes/new_post.dart';
import 'package:cinaddict/utils/shared_preferences.dart';
import 'package:cinaddict/utils/colors.dart';
import 'package:cinaddict/models/user.dart';
import 'package:cinaddict/services/firestore.dart';
import 'package:cinaddict/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:async/async.dart';

import 'edit_profile_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late User user = widget.user;

  Future<void> _getUser() async {
    User _user = await AppFirestore.getUser(user.username);
    setState(() {
      user = _user;
    });
  }

  Widget? setBody() {
    return RefreshIndicator(
      onRefresh: () async {
        await _getUser();
      },
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 12.0, 0, 12.0),
                child: CircleAvatar(
                  child: ClipOval(
                      child: Image.asset("lib/assets/cinaddict_logo.png")),
                  radius: 50,
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 24.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "${user.posts.length}",
                              style: AppTextStyle.whiteTextStyle,
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 8.0, 0, 0)),
                            Text(
                              "Posts",
                              style: AppTextStyle.lighterbiggerTextStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "${user.followers.length}",
                              style: AppTextStyle.whiteTextStyle,
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 8.0, 0, 0)),
                            Text(
                              "Followers",
                              style: AppTextStyle.lighterbiggerTextStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "${user.following.length}",
                              style: AppTextStyle.whiteTextStyle,
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 8.0, 0, 0)),
                            Text(
                              "Following",
                              style: AppTextStyle.lighterbiggerTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: () {},
                        child: Text(
                          "Follow",
                          style: AppTextStyle.darkTextStyle,
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        child: Text(
                          "Message",
                          style: AppTextStyle.darkTextStyle,
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          // Text("Username: ${user.username}"),
          Container(
            // width: 200.0,
            height: 30.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0.0),
            ),
            child: Row(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '   ', //display_name
                  style: AppTextStyle.whiteTextStyle,
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Charles Dickens', //display_name
                    style: AppTextStyle.whiteTextStyle,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
          Container(
            height: 45.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0.0),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '   ', //display_name
                  style: AppTextStyle.whiteTextStyle,
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Movie fan/ Part-time blogger', //description
                    style: AppTextStyle.lighterTextStyle,
                  ),
                ),
              ],
            ),
          ),
          GridView.count(
            shrinkWrap: true,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
            crossAxisCount: 3,
            physics: NeverScrollableScrollPhysics(),
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(0),
                  child: Image.network(
                      'https://www.linkpicture.com/q/IMG_2031-2_1.jpg',
                      fit: BoxFit.cover),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(0),
                  child: Image.network(
                      'https://www.linkpicture.com/q/IMG_2034-2.jpg',
                      fit: BoxFit.cover),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(0),
                  child: Image.network(
                      'https://www.linkpicture.com/q/IMG_2032-2_1.jpg',
                      fit: BoxFit.cover),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(0),
                  child: Image.network(
                      'https://www.linkpicture.com/q/IMG_2036-3.jpg',
                      fit: BoxFit.cover),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(0),
                  child: Image.network(
                      'https://www.linkpicture.com/q/IMG_2037-2_1.jpg',
                      fit: BoxFit.cover),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.alternativeRed,
          automaticallyImplyLeading: false,
          leading: Image(
            image: AssetImage(
              'lib/assets/cinaddict_logo.png',
            ),
          ),
          title: Text(
            '@${user.username}',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontStyle: FontStyle.italic),
          ),
          actions: [
            SizedBox(
              width: 35,
              child: IconButton(
                icon: Icon(Icons.add, color: Colors.orangeAccent[300]),
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              NewPost(username: user.username)));
                },
              ),
            ),
            SizedBox(
              child: IconButton(
                icon: Icon(Icons.edit, color: Colors.orangeAccent[300]),
                onPressed: () async {
                  Map<String, dynamic> data = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfile(user: user)))
                      as Map<String, dynamic>;
                  print('My name in profile ${data['name']}');
                },
              ),
            ),
          ],
        ),
        body: setBody());
  }
}
