import 'package:foodie/services/auth_services.dart';
import 'package:foodie/services/recipe_services.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupFinder() {
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => RecipeService());
}