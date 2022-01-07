// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      json['content'] as String,
      DateTime.parse(json['timestamp'] as String),
      json['writtenBy'] as String,
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'writtenBy': instance.writtenBy,
      'content': instance.content,
      'timestamp': instance.timestamp.toIso8601String(),
    };
