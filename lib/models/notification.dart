import 'package:cinaddict/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable(explicitToJson: true)
class Notification {
  Notification(
      this.user,
      this.notificationType,
      this.timestamp
      );

  String notificationType;
  User user;
  DateTime timestamp;

  factory Notification.fromJson(Map<String, dynamic> json) => _$NotificationFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationToJson(this);
}

class NotificationType {
  static String followed = 'followed';
  static String followRequest = 'followRequest';
  static String commentedOnPost = 'commentedOnPost';
  static String likedPost = 'likedPost';
  static String likedComment = 'likedComment';
}