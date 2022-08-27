import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsService {
  final FirebaseMessaging _firebaseMessaging;

  PushNotificationsService({
    required FirebaseMessaging firebaseMessaging,
  }) : _firebaseMessaging = firebaseMessaging;

  Future<void> init() async {
    await _firebaseMessaging.setAutoInitEnabled(false);

    print(await _firebaseMessaging.getToken());
    final settings = await _firebaseMessaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        log('Notification when app is on foreground');
      });
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        log('User opened the app on that message');
      });
    } else {
      log('User declined or has not accepted permission');
    }
  }
}
