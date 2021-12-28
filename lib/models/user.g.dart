// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['description'] as String,
      json['username'] as String,
      json['displayName'] as String,
      (json['followers'] as List<dynamic>).map((e) => e as String).toList(),
      (json['following'] as List<dynamic>).map((e) => e as String).toList(),
      json['isPrivate'] as bool,
      (json['posts'] as List<dynamic>)
          .map((e) => Post.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['notifications'] as List<dynamic>)
          .map((e) => Notification.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['followRequests'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'username': instance.username,
      'displayName': instance.displayName,
      'isPrivate': instance.isPrivate,
      'followers': instance.followers,
      'following': instance.following,
      'description': instance.description,
      'posts': instance.posts.map((e) => e.toJson()).toList(),
      'notifications': instance.notifications.map((e) => e.toJson()).toList(),
      'followRequests': instance.followRequests.map((e) => e.toJson()).toList(),
    };
