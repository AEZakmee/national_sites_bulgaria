// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRoom _$ChatRoomFromJson(Map<String, dynamic> json) => ChatRoom(
      siteId: json['siteId'] as String,
      roomName: json['roomName'] as String,
      roomImage: json['roomImage'] as String,
      imageHash: json['imageHash'] as String,
      lastMessage: json['lastMessage'] as String,
      lastMessageTime: DateTime.parse(json['lastMessageTime'] as String),
    );

Map<String, dynamic> _$ChatRoomToJson(ChatRoom instance) => <String, dynamic>{
      'siteId': instance.siteId,
      'roomName': instance.roomName,
      'roomImage': instance.roomImage,
      'imageHash': instance.imageHash,
      'lastMessage': instance.lastMessage,
      'lastMessageTime': instance.lastMessageTime.toIso8601String(),
    };
