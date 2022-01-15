import 'package:json_annotation/json_annotation.dart';
import 'comment.dart';

part 'post.g.dart';

@JsonSerializable(explicitToJson: true)
class Post {
  Post({
    required this.owner,
    required this.image,
    required this.description,
    required this.like,
    required this.dislike,
    required this.comments,
    required this.timestamp,
    this.reSharedFrom = "None",
  });

  String owner;
  String image;
  String description;
  List<String> like;
  List<String> dislike;
  List<Comment> comments;
  String reSharedFrom;
  DateTime timestamp;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
