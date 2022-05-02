import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class ChatMessage {
  String userId;
  String userName;
  String message;
  DateTime sendTime;

  ChatMessage({
    required this.userId,
    required this.userName,
    required this.message,
    required this.sendTime,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);
  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);
}
