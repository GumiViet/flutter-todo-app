import 'package:flutter_to_do/screens/home/stack/card_view/item/stack_card_view.view_model.dart';
import 'package:flutter_to_do/screens/splash/splash.view_model.dart';
import 'package:get_it/get_it.dart';

import 'data/database/todo.database.dart';

GetIt byInject = GetIt.instance;

void initInject() {
  byInject
      .registerFactory<StackCardViewViewModel>(() => StackCardViewViewModel());
  byInject.registerLazySingleton<DBProvider>(() => DBProvider());
  byInject.registerFactory<SplashViewModel>(() => SplashViewModel());
}
