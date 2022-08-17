import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../app/locator.dart';
import '../../data/models/app_user.dart';
import '../../data/models/chat_room.dart';
import '../../data/models/message.dart';
import '../../data/sites_repo.dart';
import '../../services/firestore_service.dart';

class ChatRoomVM extends ChangeNotifier {
  final FirestoreService _fireStoreService;
  final DataRepo _dataRepo;

  ChatRoomVM({
    required fireStoreService,
    required dataRepo,
  })  : _fireStoreService = fireStoreService,
        _dataRepo = dataRepo;

  final TextEditingController controller = TextEditingController();

  Map<String, AppUser> chatUsers = {};

  late ChatRoom room;

  Stream<List<ChatMessage>> get messagesStream =>
      _fireStoreService.messagesStream(room.siteId);

  void init(ChatRoom room) {
    this.room = room;
  }

  bool sendByUser(ChatMessage message) =>
      message.userId == _dataRepo.user.uniqueID;

  Future<void> sendMessage() async {
    if (controller.text.isEmpty) {
      return;
    }
    final message = ChatMessage(
      userId: _dataRepo.user.uniqueID,
      userReference: FirebaseFirestore.instance.doc(
        'users/${_dataRepo.user.uniqueID}',
      ),
      message: controller.text,
      sendTime: DateTime.now(),
    );
    controller.clear();
    await _fireStoreService.sendMessage(message, room.siteId);
  }

  Future<AppUser> getUserData(
    DocumentReference<Map<String, dynamic>> ref,
    String userId,
  ) async {
    AppUser? user = chatUsers[userId];
    if (user != null) {
      return user;
    }
    user = await ref.get().then(
          (value) => AppUser.fromJson(value.data()!),
        );
    chatUsers[user!.uniqueID] = user;
    return user;
  }
}
