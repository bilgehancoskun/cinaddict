import 'package:cinaddict/models/post.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  User(
      this.description,
      this.username,
      this.displayName,
      this.followers,
      this.following,
      this.isPrivate,
      this.posts
      );
  // TODO: Implement profile picture
  String username;
  String displayName;
  bool isPrivate;
  List<String> followers;
  List<String> following;
  String description;
  List<Post> posts;


  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}