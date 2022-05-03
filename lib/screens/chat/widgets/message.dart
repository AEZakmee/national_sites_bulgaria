import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart';

import '../../../../data/models/message.dart';
import '../../../utilitiies/extensions.dart';
import '../../../widgets/cached_image.dart';

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
              return _SendByCurrentUser(
                message: message,
                first: first,
                last: last,
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
          left: 100,
          right: 2,
          top: 2,
          bottom: first ? 10 : 2,
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Spacer(),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(15),
                      bottomLeft: const Radius.circular(15),
                      topRight: last ? const Radius.circular(15) : Radius.zero,
                      bottomRight:
                          first ? const Radius.circular(15) : Radius.zero,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      message.message,
                      style: Theme.of(context).textTheme.bodyMedium,
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

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(
          left: 2,
          right: 100,
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
                      message.userName,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 2, right: 8),
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: first
                        ? Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).splashColor,
                            ),
                            child: Center(
                              child: Text(
                                message.userName.parsePersonTwoCharactersName(),
                              ),
                            ),
                          )
                        : null,
                  ),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
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
                      style: Theme.of(context).textTheme.bodyMedium,
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
