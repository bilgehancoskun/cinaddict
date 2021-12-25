import 'package:cinaddict/models/user.dart';
import 'package:cinaddict/services/firestore.dart';
import 'package:cinaddict/utils/colors.dart';
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
                              decoration: InputDecoration(

                                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                          onPressed: (){},
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
                              SizedBox(width: 90,),
                              SizedBox(
                                child: Image.network(
                                  'https://picsum.photos/250?image=9',
                                  width: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  )))),
    );
  }
}
