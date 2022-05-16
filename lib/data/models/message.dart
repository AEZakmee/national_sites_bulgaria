import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../utilitiies/firestore_json.dart';

part 'message.g.dart';

@JsonSerializable()
class ChatMessage {
  String userId;
  @JsonKey(fromJson: firebaseDocRefFromJson, toJson: firebaseDocRefToJson)
  DocumentReference<Map<String, dynamic>> userReference;
  String message;
  DateTime sendTime;

  ChatMessage({
    required this.userId,
    required this.userReference,
    required this.message,
    required this.sendTime,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);
  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);
}
