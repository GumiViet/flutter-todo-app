import 'package:flutter/material.dart';
import 'package:flutter_to_do/resources/colors.dart';
import 'package:flutter_to_do/resources/localization/app_translations.dart';

import 'base_view_model.dart';

abstract class BaseScreen<T extends StatefulWidget> extends State<T> {
  String getString(String key) => AppTranslations.of(context).text(key);

  Widget baseScaffold({String myTitle, @required Widget myBody}) {
    return Scaffold(
      appBar: myTitle != null
          ? AppBar(
              backgroundColor: AppColors.mainColor,
              title: Text(getString(myTitle)),
            )
          : null,
      body: myBody,
    );
  }

  void goToScreen(String screen) {
    Navigator.of(context).pushNamed(screen);
  }

  void goToAndRemoveScreen(String screen) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(screen, (Route<dynamic> route) => false);
  }
}
