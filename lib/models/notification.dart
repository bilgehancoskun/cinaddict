import 'package:cinaddict/models/post.dart';
import 'package:cinaddict/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable(explicitToJson: true)
class Notification {
  Notification(
      this.username,
      this.notificationType,
      this.post,
      this.timestamp,
      );

  String notificationType;
  String username;
  Post? post;
  DateTime timestamp;

  factory Notification.fromJson(Map<String, dynamic> json) => _$NotificationFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationToJson(this);
}

class NotificationType {
  static String followed = 'followed';
  static String followRequest = 'followRequest';
  static String commentedOnPost = 'commentedOnPost';
  static String acceptedRequest = 'acceptedRequest';
  static String likedPost = 'likedPost';
}