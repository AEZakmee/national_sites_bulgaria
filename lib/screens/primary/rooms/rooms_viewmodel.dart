import 'package:flutter/cupertino.dart';

import '../../../app/locator.dart';
import '../../../app/router.dart';
import '../../../data/models/chat_room.dart';
import '../../../services/firestore_service.dart';

class RoomsVM extends ChangeNotifier {
  final _fireStoreService = locator<FirestoreService>();

  Stream<List<ChatRoom>> get roomsStream => _fireStoreService.roomsStream();

  Future<void> openChat(BuildContext context, String id) async {
    final freshRoom = await _fireStoreService.fetchRoom(id);
    await Navigator.of(context).pushNamed(
      Routes.chat,
      arguments: ChatRoomArguments(freshRoom),
    );
  }
}
