// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notification _$NotificationFromJson(Map<String, dynamic> json) => Notification(
      User.fromJson(json['user'] as Map<String, dynamic>),
      json['notificationType'] as String,
      DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'notificationType': instance.notificationType,
      'user': instance.user.toJson(),
      'timestamp': instance.timestamp.toIso8601String(),
    };
