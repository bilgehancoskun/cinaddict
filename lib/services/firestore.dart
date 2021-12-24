import 'package:cinaddict/models/post.dart';
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
        })
        .then((value) => print("User Added: $username"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  static Future<bool> updateUser(
      String username, String key, dynamic value) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    users
        .doc(username)
        .set({key: value}, SetOptions(merge: true))
        .then((value) => print("User Updated: $username - $key"))
        .catchError((error) => print("Failed to update user: $error"));
    return true;

    // TODO: Change this operation to await and handle errors return false if needed.
  }

  static Future<User> getUser(String username) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    DocumentSnapshot snapshot = await users.doc(username).get();
    Map<String, dynamic> userJson = snapshot.data() as Map<String, dynamic>;
    User user = User.fromJson(userJson);
    return user;
  }

  static Future<bool> addPost(String username, Post newPost) async {
    User user = await getUser(username);
    Map<String, dynamic> jsonUser = user.toJson();
    jsonUser['posts'].add(newPost.toJson());
    updateUser(username, 'posts', jsonUser['posts']);
    return true;
  }
}
