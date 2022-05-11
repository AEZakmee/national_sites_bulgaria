import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart';

import '../../../data/models/chat_room.dart';
import '../../../widgets/cached_image.dart';
import '../../../widgets/viewmodel_builder.dart';
import '../widgets/custom_appbar_container.dart';
import 'rooms_viewmodel.dart';

class RoomsBody extends StatelessWidget {
  const RoomsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ViewModelBuilder<RoomsVM>(
        viewModelBuilder: RoomsVM.new,
        builder: (context, _) => Column(
          children: const [
            CustomAppBarContainer(),
            Expanded(
              child: _RoomsListView(),
            ),
          ],
        ),
      );
}

class _RoomsListView extends StatelessWidget {
  const _RoomsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => StreamBuilder<List<ChatRoom>>(
        stream: context.read<RoomsVM>().roomsStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox.shrink();
          }
          final rooms = snapshot.data!;
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                width: double.infinity,
                height: 1,
                color: Theme.of(context).dividerColor,
              ),
              ...List.generate(
                rooms.length,
                (index) => InkWell(
                  onTap: () => context
                      .read<RoomsVM>()
                      .openChat(context, rooms[index].siteId),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SizedBox(
                                height: 60,
                                width: 60,
                                child: CustomCachedImage(
                                  url: rooms[index].roomImage,
                                  hash: rooms[index].imageHash,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width - 100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      rooms[index].roomName,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      rooms[index].lastMessage,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        const Spacer(),
                                        Text(
                                          format(
                                            rooms[index].lastMessageTime,
                                            locale:
                                                Localizations.localeOf(context)
                                                    .languageCode,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Theme.of(context).dividerColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      );
}
