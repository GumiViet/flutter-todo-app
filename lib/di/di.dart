import 'package:flutter_to_do/screen/add/add_item_view_model.dart';
import 'package:flutter_to_do/screen/detail/detail_item_view_model.dart';
import 'package:flutter_to_do/screen/edit/edit_item_view_model.dart';
import 'package:flutter_to_do/screen/home/home_view_model.dart';
import 'package:flutter_to_do/screen/splash/splash_view_model.dart';
import 'package:get_it/get_it.dart';

GetIt byInject = GetIt.instance;

void initInject() {
  //Inject some thing model
  byInject.registerFactory<SplashViewModel>(() => SplashViewModel());
  byInject.registerFactory<HomeViewModel>(() => HomeViewModel());
  byInject.registerFactory<AddItemViewModel>(() => AddItemViewModel());
  byInject.registerFactory<EditItemViewModel>(() => EditItemViewModel());
  byInject.registerFactory<DetailItemViewModel>(() => DetailItemViewModel());
}
