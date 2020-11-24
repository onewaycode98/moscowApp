import 'package:get_it/get_it.dart';
import 'package:todoapp/core/models/CRUD_model.dart';
import 'package:todoapp/core/services/api.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Api('tasks'));
  locator.registerLazySingleton(() => CRUDModel());
}
