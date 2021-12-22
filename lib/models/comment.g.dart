// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      json['dislikeCount'] as int,
      json['likeCount'] as int,
      json['content'] as String,
      DateTime.parse(json['timestamp'] as String),
      json['writtenBy'] as String,
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'writtenBy': instance.writtenBy,
      'content': instance.content,
      'likeCount': instance.likeCount,
      'dislikeCount': instance.dislikeCount,
      'timestamp': instance.timestamp.toIso8601String(),
    };
