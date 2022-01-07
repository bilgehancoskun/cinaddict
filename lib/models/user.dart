import 'package:cinaddict/models/notification.dart';
import 'package:cinaddict/models/post.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  User(
      this.uid,
      this.description,
      this.username,
      this.displayName,
      this.followers,
      this.following,
      this.isPrivate,
      this.posts,
      this.notifications,
      this.followRequests,
      this.profilePicture
      );

  String uid;
  String profilePicture;
  String username;
  String displayName;
  bool isPrivate;
  List<String> followers;
  List<String> following;
  String description;
  List<Post> posts;
  List<Notification> notifications;
  List<User> followRequests;


  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}