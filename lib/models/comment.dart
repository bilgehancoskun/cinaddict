import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable(explicitToJson: true)
class Comment {
  Comment(
      this.content,
      this.timestamp,
      this.writtenBy
      );

  String writtenBy;
  String content;
  DateTime timestamp;



  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}