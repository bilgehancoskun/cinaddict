// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notification _$NotificationFromJson(Map<String, dynamic> json) => Notification(
      json['username'] as String,
      json['notificationType'] as String,
      json['post'] == null
          ? null
          : Post.fromJson(json['post'] as Map<String, dynamic>),
      DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'notificationType': instance.notificationType,
      'username': instance.username,
      'post': instance.post?.toJson(),
      'timestamp': instance.timestamp.toIso8601String(),
    };
