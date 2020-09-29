import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_to_do/base/base_screen.dart';
import 'package:flutter_to_do/di/di.dart';
import 'package:flutter_to_do/resources/colors.dart';
import 'package:flutter_to_do/resources/constants.dart';
import 'package:flutter_to_do/screen/splash/splash_view_model.dart';
import 'package:provider/provider.dart';
import 'package:route_annotation/route_annotation.dart';

@RoutePage(isInitialRoute: true)
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
            myBody: SpinKitDoubleBounce(
          color: AppColors.mainColor,
          size: 50,
        ));
      }),
    );
  }

  void loadData() async {
    Timer(Duration(milliseconds: 500), () {
      goToAndRemoveScreen(AppConstants.ROUTE_HOME_SCREEN);
    });
  }
}
