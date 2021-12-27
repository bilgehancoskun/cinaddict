// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      owner: json['owner'] as String?,
      image: json['image'] as String?,
      description: json['description'] as String?,
      likeCount: json['likeCount'] as int?,
      dislikeCount: json['dislikeCount'] as int?,
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'owner': instance.owner,
      'image': instance.image,
      'description': instance.description,
      'likeCount': instance.likeCount,
      'dislikeCount': instance.dislikeCount,
      'comments': instance.comments?.map((e) => e.toJson()).toList(),
      'timestamp': instance.timestamp?.toIso8601String(),
    };
