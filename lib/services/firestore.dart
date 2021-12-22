import 'package:cinaddict/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppFirestore {

  static Future<void> addUserToFirestore(String username) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return users
        .doc(username)
        .set({
      'displayName': '',
      'username': username,
      'posts': [],
      'followers': [],
      'following': [],
      'description': '',
      'isPrivate': false,

    }).then((value) => print("User Added: $username")).catchError((error) => print("Failed to add user: $error"));

  }

  static Future<User> getUser(String username) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    DocumentSnapshot snapshot = await users.doc(username).get();
    Map<String, dynamic> userJson = snapshot.data() as Map<String, dynamic>;
    print(userJson);
    User user = User.fromJson(userJson);
    print(user);
    return user;
  }

}