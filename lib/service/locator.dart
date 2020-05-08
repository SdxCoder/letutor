import 'package:get_it/get_it.dart';
import 'package:letutor/service/db_service.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => DatabaseService());
}
