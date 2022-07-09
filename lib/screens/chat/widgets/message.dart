import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart';

import '../../../../data/models/message.dart';
import '../../../data/models/app_user.dart';
import '../../../utilitiies/extensions.dart';
import '../../../widgets/cached_image.dart';
import '../chat_room_viewmodel.dart';

class MessageBox extends StatelessWidget {
  const MessageBox({
    required this.message,
    required this.sendByUser,
    required this.first,
    required this.last,
    required this.overOneHour,
    Key? key,
  }) : super(key: key);
  final ChatMessage message;
  final bool sendByUser;
  final bool first;
  final bool last;
  final bool overOneHour;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          if (overOneHour && last)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                format(
                  message.sendTime,
                  locale: Localizations.localeOf(context).languageCode,
                ),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          Builder(builder: (context) {
            if (sendByUser) {
              return GestureDetector(
                //todo: add delete
                onLongPress: () {},
                child: _SendByCurrentUser(
                  message: message,
                  first: first,
                  last: last,
                ),
              );
            }
            return _SendByAnotherUser(
              message: message,
              first: first,
              last: last,
            );
          }),
        ],
      );
}

class _SendByCurrentUser extends StatelessWidget {
  const _SendByCurrentUser({
    required this.message,
    required this.first,
    required this.last,
    Key? key,
  }) : super(key: key);
  final ChatMessage message;
  final bool first;
  final bool last;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(
          right: 2,
          top: 2,
          bottom: first ? 10 : 2,
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Spacer(),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.8,
                  ),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.75),
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(15),
                        bottomLeft: const Radius.circular(15),
                        topRight:
                            last ? const Radius.circular(15) : Radius.zero,
                        bottomRight:
                            first ? const Radius.circular(15) : Radius.zero,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        message.message,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (first)
              Padding(
                padding: const EdgeInsets.only(top: 2, right: 10),
                child: Row(
                  children: [
                    const Spacer(),
                    Text(
                      format(
                        message.sendTime,
                        locale: Localizations.localeOf(context).languageCode,
                      ),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              )
          ],
        ),
      );
}

class _SendByAnotherUser extends StatelessWidget {
  const _SendByAnotherUser({
    required this.message,
    required this.first,
    required this.last,
    Key? key,
  }) : super(key: key);
  final ChatMessage message;
  final bool first;
  final bool last;

  Widget imageDialog(context, AppUser user) => Dialog(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.width * 0.7,
          color: Theme.of(context).backgroundColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.width * 0.6,
                child: CustomCachedImage(
                  borderRadius: BorderRadius.circular(15),
                  url: user.picture!,
                ),
              ),
              Text(
                user.username,
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(
          left: 2,
          top: 2,
          bottom: first ? 10 : 2,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (last)
              Padding(
                padding: const EdgeInsets.only(bottom: 2, left: 50),
                child: Row(
                  children: [
                    Text(
                      '',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 2, right: 8),
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: FutureBuilder<AppUser>(
                      future: context.read<ChatRoomVM>().getUserData(
                            message.userReference,
                            message.userId,
                          ),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const SizedBox.shrink();
                        }
                        final data = snapshot.data;
                        if (data == null) {
                          return const SizedBox.shrink();
                        }
                        return first
                            ? data.picture != null
                                ? GestureDetector(
                                    onTap: () => showDialog(
                                      context: context,
                                      builder: (_) => imageDialog(
                                        context,
                                        data,
                                      ),
                                    ),
                                    child: CustomCachedImage(
                                      url: data.picture!,
                                      shape: BoxShape.circle,
                                    ),
                                  )
                                : DecoratedBox(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context).splashColor,
                                    ),
                                    child: Center(
                                      child: Text(
                                        data.username
                                            .parsePersonTwoCharactersName(),
                                      ),
                                    ),
                                  )
                            : const SizedBox.shrink();
                      },
                    ),
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .secondaryHeaderColor
                          .withOpacity(0.5),
                      borderRadius: BorderRadius.only(
                        topLeft: last ? const Radius.circular(15) : Radius.zero,
                        bottomLeft:
                            first ? const Radius.circular(15) : Radius.zero,
                        topRight: const Radius.circular(15),
                        bottomRight: const Radius.circular(15),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        message.message,
                        maxLines: 100,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.black
                                  : Colors.white,
                            ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
            if (first)
              Padding(
                padding: const EdgeInsets.only(top: 2, left: 50),
                child: Row(
                  children: [
                    Text(
                      format(
                        message.sendTime,
                        locale: Localizations.localeOf(context).languageCode,
                      ),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Spacer(),
                  ],
                ),
              )
          ],
        ),
      );
}
