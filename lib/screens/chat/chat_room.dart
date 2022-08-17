import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/locator.dart';
import '../../data/models/chat_room.dart';
import '../../data/models/message.dart';
import '../../utilitiies/constants.dart';
import '../../widgets/colored_safe_area.dart';
import '../../widgets/keyboard_dismisser.dart';
import '../../widgets/viewmodel_builder.dart';
import 'chat_room_viewmodel.dart';
import 'widgets/message.dart';

const _bottomHeight = 80.0;

class ChatRoomScreen extends StatelessWidget {
  const ChatRoomScreen({
    required this.room,
    Key? key,
  }) : super(key: key);

  final ChatRoom room;

  @override
  Widget build(BuildContext context) => ViewModelBuilder<ChatRoomVM>(
        viewModelBuilder: locator<ChatRoomVM>,
        onModelReady: (viewModel) => viewModel.init(room),
        builder: (context, viewModel) => ColoredSafeArea(
          topColor: Theme.of(context).primaryColor,
          bottomColor: Theme.of(context).backgroundColor,
          child: KeyboardDismissOnTap(
            child: Scaffold(
              appBar: AppBar(
                title: Text(viewModel.room.roomName),
                backgroundColor: Theme.of(context).primaryColor,
              ),
              body: Stack(
                children: const [
                  Positioned(
                    bottom: _bottomHeight,
                    top: 0,
                    right: 0,
                    left: 0,
                    child: _Body(),
                  ),
                  Positioned(
                    bottom: 0,
                    child: _SendBar(),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

class _SendBar extends StatelessWidget {
  const _SendBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        height: _bottomHeight,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          boxShadow: [kBoxShadowLiteTop(context)],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: context.read<ChatRoomVM>().controller,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: context.read<ChatRoomVM>().sendMessage,
                icon: const Icon(Icons.send),
              ),
            ),
            textInputAction: TextInputAction.send,
            onEditingComplete: context.read<ChatRoomVM>().sendMessage,
            maxLines: 3,
          ),
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

  bool overOneHourThanPrevious(ChatMessage current, ChatMessage? previous) {
    if (previous == null) {
      return true;
    }
    return current.sendTime.difference(previous.sendTime).inHours > 1;
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
              overOneHour: overOneHourThanPrevious(
                data[index],
                index < data.length - 1 ? data[index + 1] : null,
              ),
            ),
          );
        },
      );
}
