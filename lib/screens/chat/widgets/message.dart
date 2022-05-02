import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart';

import '../../../../data/models/message.dart';

class MessageBox extends StatelessWidget {
  const MessageBox({
    required this.message,
    required this.sendByUser,
    required this.first,
    required this.last,
    Key? key,
  }) : super(key: key);
  final ChatMessage message;
  final bool sendByUser;
  final bool first;
  final bool last;

  @override
  Widget build(BuildContext context) {
    if (sendByUser) {
      return _SendByCurrentUser(
        message: message.message,
        time: message.sendTime,
        first: first,
        last: last,
      );
    }
    return _SendByAnotherUser();
  }
}

class _SendByCurrentUser extends StatelessWidget {
  const _SendByCurrentUser({
    required this.message,
    required this.time,
    required this.first,
    required this.last,
    Key? key,
  }) : super(key: key);
  final String message;
  final DateTime time;
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
                Expanded(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
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
                        message,
                        style: Theme.of(context).textTheme.bodyMedium,
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
                        time,
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
  const _SendByAnotherUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
