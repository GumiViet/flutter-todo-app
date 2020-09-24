import 'package:flutter/material.dart';
import 'package:flutter_to_do/resources/constants.dart';
import 'package:flutter_to_do/screen/add/add_item_screen.dart';
import 'package:flutter_to_do/screen/detail/detail_item_screen.dart';
import 'package:flutter_to_do/screen/edit/edit_item_screen.dart';
import 'package:flutter_to_do/screen/home/home_screen.dart';
import 'package:flutter_to_do/screen/splash/splash_screen.dart';

RouteFactory generateRoute = (setting) => Map.fromEntries([
      ...getScreen(AppConstants.ROUTE_SPLASH, SplashScreen()).entries,
      ...getScreen(AppConstants.ROUTE_HOME_SCREEN, HomeScreen()).entries,
      ...getScreen(AppConstants.ROUTE_ADD_ITEM_SCREEN, AddItemScreen()).entries,
      ...getScreen(AppConstants.ROUTE_DETAIL_ITEM_SCREEN, DetailItemScreen())
          .entries,
      ...getScreen(AppConstants.ROUTE_EDIT_ITEM_SCREEN, EditItemScreen())
          .entries,
    ])[setting.name](setting);

Map<String, RouteFactory> getScreen(String router, StatefulWidget screen) =>
    <String, RouteFactory>{
      router: (RouteSettings settings) => MaterialPageRoute(
            builder: (BuildContext context) => screen,
          ),
    };
