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
  static Future<void> addUserToFirestore({required String uid, required String username, String displayName = '', String description = '', String profilePicture = 'app/cinaddict_logo.png'}) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return users
        .doc(username)
        .set({
      'uid': uid,
      'displayName': displayName,
      'username': username,
      'posts': [],
      'followers': [],
      'following': [],
      'notifications': [],
      'description': description,
      'isPrivate': false,
      'followRequests': [],
      'profilePicture': profilePicture
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

  static Future <List<Post>> searchPost(String keyword) async{
    List<Post> postDescription = [];
    QuerySnapshot<Map<String, dynamic>>searchResult;
    CollectionReference _posts = FirebaseFirestore.instance.collection('users');
    print(keyword);
    Query userQuery = _posts.where('description', isGreaterThanOrEqualTo: keyword,
      isLessThan: keyword.substring(0, keyword.length - 1) +
          String.fromCharCode(keyword.codeUnitAt(keyword.length - 1) + 1),);
    searchResult = await userQuery.get() as QuerySnapshot<Map<String, dynamic>>;
    if (searchResult.docs.isNotEmpty) {
      for (int i = 0; i < searchResult.docs.length; i++) {
        postDescription.add(
            Post.fromJson(searchResult.docs[i].data())
        );
      }
    }
    return postDescription;
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
    String path = 'None',
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

  static Future<void> uploadPostImageForReShare({
    required String reSharedFrom,
    required String username,
    required String imageName
  }) async {
    String currentImagePath = '$reSharedFrom/posts/$imageName';
    File file = await FirebaseCacheManager().getSingleFile(currentImagePath);
    String imagePath = '$username/posts/$imageName';
    try {
      await FirebaseStorage.instance.ref(imagePath).putFile(file);
    } on FirebaseException catch (e) {
      print("While uploading file error occurred: $e");
    }
  }

  static Future<void> uploadProfilePicture({
    required String username,
    required String path,
    required String imageName
  }) async {
    String imagePath = '$username/profile/$imageName';
    File file = File(path);
    try {
      await FirebaseStorage.instance.ref(imagePath).putFile(file);
    } on FirebaseException catch (e) {
      print("While uploading file error occurred: $e");
    }
  }

  static Future<ImageProvider> getProfilePictureFromName(String username,
      String imageName) async {
    try {
      String imagePath = '$username/profile/$imageName';
      if(imageName.contains(RegExp(r'cinaddict_logo', caseSensitive: false)))
          imagePath = 'app/cinaddict_logo.png';

      File file = await FirebaseCacheManager().getSingleFile(imagePath);
      return FileImage(file);

    } catch(e) {
      return AssetImage("lib/assets/cinaddict_logo.png");
    }
  }

  static Future<bool> followUser({required String user, required String willFollow, String sentFrom = 'None'}) async {
    bool result = false;
    try {
      CollectionReference users = FirebaseFirestore.instance.collection('users');

      DocumentSnapshot willFollowSnapshot = await users.doc(willFollow).get();
      Map<String, dynamic> willFollowSnapshotUserJson = willFollowSnapshot.data() as Map<String, dynamic>;
      DocumentSnapshot snapshot = await users.doc(user).get();
      Map<String, dynamic> userJson = snapshot.data() as Map<String, dynamic>;

      if (willFollowSnapshotUserJson['isPrivate'] && sentFrom == 'None') {
        if (await notify(who: userJson['username'], notificationType: CN.NotificationType.followRequest, user: willFollow))
          result = false;
      }
      else {
        userJson['following'].add(willFollow);
        await users.doc(user).update(userJson);

        willFollowSnapshotUserJson['followers'].add(user);
        await users.doc(willFollow).update(willFollowSnapshotUserJson);
        if (await notify(who: userJson['username'], notificationType: CN.NotificationType.followed, user: willFollow))
          result = true;
      }

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

  static Future<bool> notify({required String who, required String notificationType, Post? post, required String user}) async {
    bool result = false;
    CN.Notification notification = CN.Notification(who, notificationType, post, DateTime.now());
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

  static Future<bool> reportPost({required String reportedBy, required Post post}) async {
    bool result = false;
    Map<String, dynamic> reportedPostsJson = {};
    CollectionReference reportedPosts = FirebaseFirestore.instance.collection('reportedPosts');
    DocumentSnapshot snapshot = await reportedPosts.doc(post.owner).get();
    if (snapshot.exists) {
      reportedPostsJson = snapshot.data() as Map<String, dynamic>;
    }
    String postJson = post.toJson().toString();
    if (reportedPostsJson.keys.contains(postJson)) {
      if (!reportedPostsJson[postJson].contains(reportedBy))
        reportedPostsJson[postJson].add(reportedBy);
    }
    else {
      reportedPostsJson[postJson] = [reportedBy];
    }

    reportedPosts
        .doc(post.owner)
        .set({postJson: reportedPostsJson[postJson]}, SetOptions(merge: true))
        .then((value) => print("Reported Posts Update"))
        .catchError((error) => print("Failed to update user: $error"));

    return result;
  }

  static Future<bool> updatePost(Post post) async {
    bool result = false;
    try {
      User user = await getUser(post.owner);
      for (int idx = 0; idx < user.posts.length; idx++) {
        if (user.posts[idx].timestamp == post.timestamp) {
          user.posts[idx] = post;
        }
      }

      Map<String, dynamic> jsonUser = user.toJson();
      await updateUser(jsonUser['username'], 'posts', jsonUser['posts']);
      result = true;
    } catch (e) {
      print("Error Occurred while updating post:\n$e");
    }
    return result;
  }

  static Future<Post?> getPost(Post post) async {
    try {
      User user = await getUser(post.owner);
      for (int idx = 0; idx < user.posts.length; idx++) {
        if (user.posts[idx].timestamp == post.timestamp) {
          return user.posts[idx];
        }
      }
    } catch (e) {
      print("Error Occurred while updating post:\n$e");
      return null;
    }
    return null;
  }

  static Future<bool> deletePost(Post post) async {
    bool result = false;
    try {
      User user = await getUser(post.owner);
      for (int idx = 0; idx < user.posts.length; idx++) {
        if (user.posts[idx].timestamp == post.timestamp) {
          user.posts.removeAt(idx);
        }
      }

      Map<String, dynamic> jsonUser = user.toJson();
      await updateUser(jsonUser['username'], 'posts', jsonUser['posts']);
      result = true;
    } catch (e) {
      print("Error Occurred while deleting post:\n$e");
    }
    return result;
  }

  static Future<bool> userExists(String username) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    DocumentSnapshot snapshot = await users.doc(username).get();
    print(snapshot.exists);
    return snapshot.exists;
  }
  
  static Future<User?> getUserWithUID(String uid) async {
    User? user;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    Query query = users.where('uid', isEqualTo: uid);
    QuerySnapshot snapshot = await query.get();
    if (snapshot.docs.isNotEmpty) {
      Map<String, dynamic> userJson = snapshot.docs.first.data() as Map<String, dynamic>;
      user = User.fromJson(userJson);
    }
    return user;
  }

  static Future<bool> deleteNotification(String fromWho, CN.Notification notification) async {
    bool result = false;
    try {
      User user = await getUser(fromWho);
      for (int idx = 0; idx < user.notifications.length; idx++) {
        if (user.notifications[idx].timestamp == notification.timestamp) {
          user.notifications.removeAt(idx);
        }
      }

      Map<String, dynamic> jsonUser = user.toJson();
      await updateUser(jsonUser['username'], 'notifications', jsonUser['notifications']);
      result = true;
    } catch (e) {
      print("Error Occurred while deleting notification:\n$e");
    }
    return result;

  }

}
