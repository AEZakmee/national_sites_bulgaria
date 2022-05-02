import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/chat_room.dart';
import '../../data/models/message.dart';
import '../../widgets/viewmodel_builder.dart';
import 'chat_room_viewmodel.dart';
import 'widgets/message.dart';

class ChatRoomScreen extends StatelessWidget {
  const ChatRoomScreen({
    required this.room,
    Key? key,
  }) : super(key: key);

  final ChatRoom room;

  @override
  Widget build(BuildContext context) => ViewModelBuilder<ChatRoomVM>(
        viewModelBuilder: () => ChatRoomVM(room),
        onModelReady: (viewModel) => viewModel.init(),
        builder: (context, _) => Scaffold(
          appBar: AppBar(),
          body: const _Body(),
          bottomNavigationBar: const _SendBar(),
        ),
      );
}

class _SendBar extends StatelessWidget {
  const _SendBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 80,
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: context.read<ChatRoomVM>().controller,
              ),
            ),
            IconButton(
              onPressed: context.read<ChatRoomVM>().sendMessage,
              icon: Icon(Icons.send),
            ),
          ],
        ),
      );
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  bool firstFromThisUser(ChatMessage current, ChatMessage? previous) {
    if (previous == null) {
      return true;
    }
    return current.userId != previous.userId;
  }

  bool lastFromThisUser(ChatMessage current, ChatMessage? next) {
    if (next == null) {
      return true;
    }
    return current.userId != next.userId;
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<List<ChatMessage>>(
        stream: context.read<ChatRoomVM>().messagesStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox.shrink();
          }
          final data = snapshot.data!.reversed.toList();
          return ListView.builder(
            itemCount: data.length,
            reverse: true,
            itemBuilder: (BuildContext context, int index) => MessageBox(
              message: data[index],
              sendByUser: context.read<ChatRoomVM>().sendByUser(data[index]),
              first: firstFromThisUser(
                data[index],
                index > 0 ? data[index - 1] : null,
              ),
              last: lastFromThisUser(
                data[index],
                index < data.length - 1 ? data[index + 1] : null,
              ),
            ),
          );
        },
      );
}
