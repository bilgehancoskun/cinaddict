import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable(explicitToJson: true)
class Comment {
  Comment(
      this.dislikeCount,
      this.likeCount,
      this.content,
      this.timestamp,
      this.writtenBy
      );

  String writtenBy;
  String content;
  int likeCount;
  int dislikeCount;
  DateTime timestamp;



  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}