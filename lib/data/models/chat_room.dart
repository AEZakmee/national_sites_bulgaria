import 'package:json_annotation/json_annotation.dart';

part 'chat_room.g.dart';

@JsonSerializable()
class ChatRoom {
  String siteId;
  String roomName;
  String roomImage;
  String imageHash;
  String lastMessage;
  DateTime lastMessageTime;

  ChatRoom({
    required this.siteId,
    required this.roomName,
    required this.roomImage,
    required this.imageHash,
    required this.lastMessage,
    required this.lastMessageTime,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomFromJson(json);
  Map<String, dynamic> toJson() => _$ChatRoomToJson(this);
}
