// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) => ChatMessage(
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      message: json['message'] as String,
      sendTime: DateTime.parse(json['sendTime'] as String),
      userPhoto: json['userPhoto'] as String?,
    );

Map<String, dynamic> _$ChatMessageToJson(ChatMessage instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'message': instance.message,
      'sendTime': instance.sendTime.toIso8601String(),
      'userPhoto': instance.userPhoto,
    };
