import 'package:cinaddict/models/user.dart';
import 'package:cinaddict/routes/profile_view.dart';
import 'package:cinaddict/services/firestore.dart';
import 'package:cinaddict/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cinaddict/models/post.dart';


class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  _NavigationPage createState() => _NavigationPage();

}

class _NavigationPage extends State<NavigationPage> {
  late Post description;
  List<Post> postSearchResults = [];
  int counter = 0;
  List<User> searchResults = [];

  final _formKey = GlobalKey<FormState>();
  bool _searchActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Navigation Page'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              style: TextStyle(
                                color: AppColors.white,
                              ),
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 10, 10, 0),
                                //fillColor: Colors.grey,
                                //filled: true,
                                hintText: 'Search:',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                              ),
                              onSaved: (value) async {
                                if (value != null && value.isNotEmpty) {
                                  List<User> _searchResults =
                                      await AppFirestore.searchUser(value);
                                  setState(() {
                                    _searchActive = true;
                                    searchResults = _searchResults;
                                  });
                                }
                              },
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              _formKey.currentState!.save();
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      for (User user in searchResults)
                        OutlinedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileView(user: user, viewOnly: true, sentBy: widget.user.username,)));
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(width: 1.0, color: Colors.grey),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                user.username,
                                //style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                width: 90,
                              ),
                            ],
                          ),
                        ),
                      if (!_searchActive)
                      Column(
                        children: [
                          Image.network(
                            "https://img3.aksam.com.tr/imgsdisk/2021/11/17/t25_spider-man-no-way-home-ne-384.jpg",
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Image.network(
                                  "https://upload.wikimedia.org/wikipedia/tr/9/97/Joker_%28film%29.jpg",
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Image.network(
                                  "https://m.media-amazon.com/images/M/MV5BN2FjNmEyNWMtYzM0ZS00NjIyLTg5YzYtYThlMGVjNzE1OGViXkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_.jpg",
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Image.network(
                                    "https://i.ytimg.com/vi/ePpJDKfRAyM/movieposter.jpg"),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Image.network(
                              "https://stayhipp.com/wp-content/uploads/2019/07/New.jpg")
                        ],
                      ),

                    ],
                  )))),
    );
  }
}
