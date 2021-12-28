import 'package:cinaddict/models/post.dart';
import 'package:cinaddict/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_cache_manager_firebase/flutter_cache_manager_firebase.dart';
import 'package:cinaddict/models/notification.dart' as CN;
import 'dart:io';

class AppFirestore {
  static Future<void> addUserToFirestore({required String username, String displayName = '', String description = ''}) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return users
        .doc(username)
        .set({
      'displayName': displayName,
      'username': username,
      'posts': [],
      'followers': [],
      'following': [],
      'notifications': [],
      'description': description,
      'isPrivate': false,
    })
        .then((value) => print("User Added: $username"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  static Future<bool> updateUser(String username, String key,
      dynamic value) async {
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

  static Future<bool> hasUser(String username) async {
    bool hasUser = false;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    DocumentSnapshot snapshot = await users.doc(username).get();
    if (snapshot.data() != null)
      hasUser = true;

    return hasUser;
  }

  static Future<bool> addPost(String username, Post newPost) async {
    User user = await getUser(username);
    Map<String, dynamic> jsonUser = user.toJson();
    jsonUser['posts'].add(newPost.toJson());
    updateUser(username, 'posts', jsonUser['posts']);
    return true;
  }

  static Future<List<User>> searchUser(String keyword) async {
    List<User> userList = [];
    QuerySnapshot<Map<String, dynamic>> searchResult;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    print(keyword);
    Query userQuery = users.where('username', isGreaterThanOrEqualTo: keyword,
      isLessThan: keyword.substring(0, keyword.length - 1) +
          String.fromCharCode(keyword.codeUnitAt(keyword.length - 1) + 1),);
    searchResult = await userQuery.get() as QuerySnapshot<Map<String, dynamic>>;
    if (searchResult.docs.isNotEmpty) {
      for (int i = 0; i < searchResult.docs.length; i++) {
        userList.add(
            User.fromJson(searchResult.docs[i].data())
        );
      }
    }

    return userList;
  }

  /*
  * FileInfo? cacheFile = await FirebaseCacheManager().getFileFromCache(imagePath);
    if (cacheFile != null) {
      print(cacheFile.validTill);
      print(cacheFile.originalUrl);
    }
    * */

  static Future<bool> postsCached(String username,
      String imageName) async {
    bool result = false;
    String imagePath = '$username/posts/$imageName';
    FileInfo? cacheFile = await FirebaseCacheManager().getFileFromCache(imagePath);
    if (cacheFile != null) {
      result = true;
    }
    return result;
  }

  static Future getPostImageFromName(String username,
      String imageName) async {
    String imagePath = '$username/posts/$imageName';
    File file = await FirebaseCacheManager().getSingleFile(imagePath);
    return Image(image: FileImage(file),fit: BoxFit.cover,);
  }


  static Future<void> uploadPostImage({
    required String username,
    required String path,
    required String imageName
  }) async {
    String imagePath = '$username/posts/$imageName';
    File file = File(path);
    try {
      await FirebaseStorage.instance.ref(imagePath).putFile(file);
    } on FirebaseException catch (e) {
      print("While uploading file error occurred: $e");
    }
  }

  static Future<bool> followUser(String user, String willFollow) async {
    bool result = false;
    try {
      CollectionReference users = FirebaseFirestore.instance.collection('users');
      DocumentSnapshot snapshot = await users.doc(user).get();
      Map<String, dynamic> userJson = snapshot.data() as Map<String, dynamic>;
      userJson['following'].add(willFollow);
      await users.doc(user).update(userJson);

      DocumentSnapshot willFollowSnapshot = await users.doc(willFollow).get();
      Map<String, dynamic> willFollowSnapshotUserJson = willFollowSnapshot.data() as Map<String, dynamic>;
      willFollowSnapshotUserJson['followers'].add(user);
      await users.doc(willFollow).update(willFollowSnapshotUserJson);
      if (await notify(User.fromJson(userJson), CN.NotificationType.followed, willFollow))
        result = true;

    } catch (e) {
      print("Error occurred while follow operation $user - $willFollow");
    }

    return result;
  }

  static Future<bool> unfollowUser(String user, String willUnfollow) async {
    bool result = false;
    try {
      CollectionReference users = FirebaseFirestore.instance.collection('users');
      DocumentSnapshot snapshot = await users.doc(user).get();
      Map<String, dynamic> userJson = snapshot.data() as Map<String, dynamic>;
      userJson['following'].remove(willUnfollow);
      await users.doc(user).update(userJson);

      DocumentSnapshot willFollowSnapshot = await users.doc(willUnfollow).get();
      Map<String, dynamic> willFollowSnapshotUserJson = willFollowSnapshot.data() as Map<String, dynamic>;
      willFollowSnapshotUserJson['followers'].remove(user);
      await users.doc(willUnfollow).update(willFollowSnapshotUserJson);

      result = true;
    } catch (e) {
      print("Error occurred while unfollow operation $user - $willUnfollow");
    }

    return result;
  }

  static Future<List<User>> getPostsFollowing(User user) async {
    User mainUser = await getUser(user.username);
    List<User> followingUsers = [];
    for (String following in mainUser.following) {
      User newUser = await getUser(following);
      followingUsers.add(newUser);
    }

    return followingUsers;
  }

  static Future<bool> notify(User who, String notificationType, String user) async {
    bool result = false;
    CN.Notification notification = CN.Notification(who, notificationType, DateTime.now());
    try {
      CollectionReference users = FirebaseFirestore.instance.collection('users');
      DocumentSnapshot snapshot = await users.doc(user).get();
      Map<String, dynamic> userJson = snapshot.data() as Map<String, dynamic>;
      userJson['notifications'].add(notification.toJson());
      await users.doc(user).update(userJson);
      result = true;
    } catch (e) {
      print("Error occurred while notify operation $user - ${notification.notificationType}\n $e");
    }

    return result;
  }

}
