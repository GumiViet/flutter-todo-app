import 'package:flutter_to_do/data/sql/database.dart';
import 'package:flutter_to_do/screen/add/add_item_view_model.dart';
import 'package:flutter_to_do/screen/home/home_view_model.dart';
import 'package:flutter_to_do/screen/splash/splash_view_model.dart';
import 'package:get_it/get_it.dart';

GetIt byInject = GetIt.instance;

void initInject() {

  byInject.registerLazySingleton<DBProvider>(() => DBProvider());

  byInject.registerFactory<SplashViewModel>(() => SplashViewModel());
  byInject.registerFactory<HomeViewModel>(() => HomeViewModel());
  byInject.registerFactory<AddItemViewModel>(() => AddItemViewModel());
}
