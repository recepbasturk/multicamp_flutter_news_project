import 'package:get_it/get_it.dart';

import 'services/firebase_auth_service.dart';
import 'view_models/account_view_model.dart';

GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  locator.registerLazySingleton(() => FirebaseAuthService());
  locator.registerLazySingleton(() => AccountViewModel());
}
