import 'package:flutter/material.dart';
import 'package:flutter_to_do/@core/constants.dart';
import 'package:flutter_to_do/screens/home/home.screen.dart';
import 'package:flutter_to_do/screens/tutorial/tutorial.screen.dart';

import 'screens/splash/splash.screen.dart';
import 'screens/todo/add/add_item_screen.dart';

RouteFactory generateRoute = (setting) => Map.fromEntries([
      ...getScreen(AppConstants.ROUTE_SPLASH, SplashScreen()).entries,
      ...getScreen(AppConstants.ROUTE_TUTORIAL_SCREEN, TutorialScreen()).entries,
      ...getScreen(AppConstants.ROUTE_HOME_SCREEN, HomeScreen()).entries,
      ...getScreen(
          AppConstants.ROUTE_ADD_ITEM_SCREEN,
          AddItemScreen(
            model: setting.arguments,
          )).entries,
    ])[setting.name](setting);

Map<String, RouteFactory> getScreen(String router, StatefulWidget screen) =>
    <String, RouteFactory>{
      router: (RouteSettings settings) => MaterialPageRoute(
            builder: (_) => screen,
          ),
    };
