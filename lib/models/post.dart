import 'package:json_annotation/json_annotation.dart';
import 'comment.dart';
part 'post.g.dart';

@JsonSerializable(explicitToJson: true)
class Post {
  Post({
      this.image,
      this.description,
      this.likeCount,
      this.dislikeCount,
      this.comments,
      this.timestamp,
  });

  String? image;
  String? description;
  int? likeCount;
  int? dislikeCount;
  List<Comment>? comments;
  DateTime? timestamp;



  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}