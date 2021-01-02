import 'package:get_it/get_it.dart';

import 'services/firebase_auth_service.dart';
import 'services/firebase_storage_service.dart';
import 'services/firestore_db_service.dart';
import 'services/news_feed.dart';
import 'view_models/account_view_model.dart';
import 'view_models/news_view_model.dart';

GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  locator.registerLazySingleton(() => FirebaseAuthService());
  locator.registerLazySingleton(() => FirebaseStorageService());
  locator.registerLazySingleton(() => FireStoreDBService());
  locator.registerLazySingleton(() => AccountViewModel());
  locator.registerLazySingleton(() => NewsFeed());
  locator.registerLazySingleton(() => NewsViewModel());
}
