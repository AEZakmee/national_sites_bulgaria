import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';

import '../data/sites_repo.dart';
import '../providers/localization_provider.dart';
import '../providers/theme_provider.dart';
import '../screens/authentication/authentication_viewmodel.dart';
import '../screens/chat/chat_room_viewmodel.dart';
import '../screens/info/info_viewmodel.dart';
import '../screens/primary/drawer_viewmodel.dart';
import '../screens/primary/primary_viewmodel.dart';
import '../screens/primary/recommendation/recommendation_viewmodel.dart';
import '../screens/primary/rooms/rooms_viewmodel.dart';
import '../screens/primary/sites/sites_viewmodel.dart';
import '../screens/splash/splash_viewmodel.dart';
import '../services/firestore_service.dart';
import '../services/image_upload_service.dart';
import '../services/localization_service.dart';
import '../services/theme_service.dart';

final locator = GetIt.instance;

void setup() {
  locator
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => FirebaseStorage.instance)
    ..registerLazySingleton(() => FirebaseFirestore.instance)
    ..registerLazySingleton<ThemeService>(ThemeService.new)
    ..registerLazySingleton<LocalizationService>(LocalizationService.new)
    ..registerLazySingleton<ImageUploaderService>(ImageUploaderService.new)
    ..registerLazySingleton<FirestoreService>(
      () => FirestoreService(
        auth: locator<FirebaseAuth>(),
        db: locator<FirebaseFirestore>(),
        storage: locator<FirebaseStorage>(),
      ),
    )
    ..registerLazySingleton<DataRepo>(
      () => DataRepo(
        fireStoreService: locator<FirestoreService>(),
      ),
    )
    ..registerFactory<LocalizationProvider>(
      () => LocalizationProvider(
        localizationService: locator<LocalizationService>(),
      ),
    )
    ..registerFactory<ThemeProvider>(
      () => ThemeProvider(
        themeService: locator<ThemeService>(),
      ),
    )
    ..registerFactory<AuthVM>(
      () => AuthVM(
        auth: locator<FirebaseAuth>(),
        fireStoreService: locator<FirestoreService>(),
        dataRepo: locator<DataRepo>(),
      ),
    )
    ..registerFactory<ChatRoomVM>(
      () => ChatRoomVM(
        fireStoreService: locator<FirestoreService>(),
        dataRepo: locator<DataRepo>(),
      ),
    )
    ..registerFactory<InfoVM>(
      () => InfoVM(
        fireStoreService: locator<FirestoreService>(),
        dataRepo: locator<DataRepo>(),
      ),
    )
    ..registerFactory<SplashVM>(
      () => SplashVM(
        auth: locator<FirebaseAuth>(),
        dataRepo: locator<DataRepo>(),
      ),
    )
    ..registerFactory<PrimaryVM>(
      () => PrimaryVM(
        auth: locator<FirebaseAuth>(),
        dataRepo: locator<DataRepo>(),
      ),
    )
    ..registerFactory<DrawerVM>(
      () => DrawerVM(
        fireStoreService: locator<FirestoreService>(),
        imageUploaderService: locator<ImageUploaderService>(),
        dataRepo: locator<DataRepo>(),
      ),
    )
    ..registerFactory<RecommendationVM>(
      () => RecommendationVM(
        fireStoreService: locator<FirestoreService>(),
        dataRepo: locator<DataRepo>(),
      ),
    )
    ..registerFactory<RoomsVM>(
      () => RoomsVM(
        fireStoreService: locator<FirestoreService>(),
      ),
    )
    ..registerFactory<SitesVM>(
      () => SitesVM(
        dataRepo: locator<DataRepo>(),
      ),
    );
}
