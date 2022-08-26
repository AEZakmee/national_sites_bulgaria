import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timeago/timeago.dart';

import 'app/app.dart';
import 'app/locator.dart';
import 'app/providers.dart';
import 'services/localization_service.dart';
import 'services/push_notifications_service.dart';
import 'services/theme_service.dart';
import 'utilitiies/bulgarian_messages.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> initApp() async {
  setup();
  setLocaleMessages('bg', BulgarianMessages());
  final themeService = locator<ThemeService>();
  await themeService.init();
  final localizationService = locator<LocalizationService>();
  await localizationService.init();
  final pushService = locator<PushNotificationsService>();
  await pushService.init();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(
    _firebaseMessagingBackgroundHandler,
  );
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  await initApp();
  runApp(const ProviderInitializer(child: MyApp()));
}
