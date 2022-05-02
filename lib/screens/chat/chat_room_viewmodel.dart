import 'package:flutter/cupertino.dart';

import '../../app/locator.dart';
import '../../data/models/chat_room.dart';
import '../../data/models/message.dart';
import '../../data/sites_repo.dart';
import '../../services/firestore_service.dart';

class ChatRoomVM extends ChangeNotifier {
  final _fireStoreService = locator<FireStoreService>();
  final _dataRepo = locator<DataRepo>();

  final TextEditingController controller = TextEditingController();

  ChatRoom room;

  ChatRoomVM(this.room);

  Stream<List<ChatMessage>> get messagesStream =>
      _fireStoreService.messagesStream(room.siteId);

  void init() {}

  bool sendByUser(ChatMessage message) =>
      message.userId == _dataRepo.user.uniqueID;

  Future<void> sendMessage() async {
    if (controller.text.isEmpty) {
      return;
    }
    final message = ChatMessage(
      userId: _dataRepo.user.uniqueID,
      userName: _dataRepo.user.username,
      message: controller.text,
      sendTime: DateTime.now(),
    );
    controller.clear();
    await _fireStoreService.sendMessage(message, room.siteId);
  }
}
