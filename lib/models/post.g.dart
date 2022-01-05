// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      owner: json['owner'] as String,
      image: json['image'] as String,
      description: json['description'] as String,
      like: (json['like'] as List<dynamic>).map((e) => e as String).toList(),
      dislike:
          (json['dislike'] as List<dynamic>).map((e) => e as String).toList(),
      comments: (json['comments'] as List<dynamic>)
          .map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'owner': instance.owner,
      'image': instance.image,
      'description': instance.description,
      'like': instance.like,
      'dislike': instance.dislike,
      'comments': instance.comments.map((e) => e.toJson()).toList(),
      'timestamp': instance.timestamp.toIso8601String(),
    };
