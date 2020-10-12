import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_to_do/@shared/utils/utils.dart';
import 'package:flutter_to_do/@core/dependency_injection.dart';
import 'package:flutter_to_do/resources/localization/langs.dart';
import 'package:flutter_to_do/@core/constants.dart';
import 'package:flutter_to_do/resources/styles/styles.dart';
import 'package:flutter_to_do/screens/base_screen.dart';
import 'package:flutter_to_do/screens/splash/splash.view_model.dart';
import 'package:provider/provider.dart';
import 'package:route_annotation/route_annotation.dart';

@initialPage
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseScreen<SplashScreen> {
  SplashViewModel viewModel = byInject<SplashViewModel>();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<SplashViewModel>(builder: (context, viewModel, child) {
        return baseScaffold(
            myBody: Container(
          child: Center(
            child: Text(
              getStringById(AppLangs.text_app_name),
              style: AppStyles().blackRegular(70),
            ),
          ),
        ));
      }),
    );
  }

  void loadData() async {
    Timer(Duration(milliseconds: 1500), () {
      goToAndRemoveScreen(context, AppConstants.ROUTE_TUTORIAL_SCREEN);
    });
  }
}
