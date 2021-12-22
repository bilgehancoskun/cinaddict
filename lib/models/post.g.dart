// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      json['image'] as String,
      json['description'] as String,
      json['likeCount'] as int,
      json['dislikeCount'] as int,
      (json['comments'] as List<dynamic>)
          .map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'image': instance.image,
      'description': instance.description,
      'likeCount': instance.likeCount,
      'dislikeCount': instance.dislikeCount,
      'comments': instance.comments.map((e) => e.toJson()).toList(),
    };
