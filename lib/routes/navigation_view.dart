import 'package:cinaddict/models/user.dart';
import 'package:cinaddict/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPage createState() => _NavigationPage();
}

class _NavigationPage extends State<NavigationPage> {
  int counter = 0;
  List<User> searchResults = [];
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Navigation Page'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.network("https://img3.aksam.com.tr/imgsdisk/2021/11/17/t25_spider-man-no-way-home-ne-384.jpg",
              ),
              SizedBox(height: 8,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                     Expanded(
                       flex: 1,
                        child: Image.network("https://upload.wikimedia.org/wikipedia/tr/9/97/Joker_%28film%29.jpg",
                        ),
                      ),
                    Expanded(
                      flex: 1,
                      child: Image.network("https://m.media-amazon.com/images/M/MV5BN2FjNmEyNWMtYzM0ZS00NjIyLTg5YzYtYThlMGVjNzE1OGViXkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_.jpg",
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Image.network("https://i.ytimg.com/vi/ePpJDKfRAyM/movieposter.jpg"),
                    ),
                  ],
                ),
              SizedBox(height: 8,),
              Image.network("https://stayhipp.com/wp-content/uploads/2019/07/New.jpg")
            ],
          ),
        ),

      ),
    );
  }
}
