import 'package:foodie/services/auth_services.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupFinder() {
  locator.registerLazySingleton(() => AuthService());
}