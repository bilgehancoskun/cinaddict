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
      body: Column(
        children: [
          Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
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
                  TextButton(
                      onPressed: () {
                        _formKey.currentState!.save();
                      },
                      child: Text('Search'))
                ],
              )),
          for (User user in searchResults)
            Row(children: [
                Text(user.username),
            ]
            ),
        ],
      ),
    );
  }
}
