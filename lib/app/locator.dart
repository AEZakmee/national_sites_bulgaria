import 'package:get_it/get_it.dart';

import '../data/sites_repo.dart';
import '../services/firestore_service.dart';
import '../services/image_upload_service.dart';
import '../services/localization_service.dart';
import '../services/theme_service.dart';

final locator = GetIt.instance;

void setup() {
  locator
    ..registerLazySingleton<ThemeService>(ThemeService.new)
    ..registerLazySingleton<LocalizationService>(LocalizationService.new)
    ..registerLazySingleton<FirestoreService>(FirestoreService.new)
    ..registerLazySingleton<DataRepo>(DataRepo.new)
    ..registerLazySingleton<ImageUploaderService>(ImageUploaderService.new);
}
