import 'package:flutter/material.dart';
import 'package:flutter_to_do/resources/colors.dart';
import 'package:flutter_to_do/resources/localization/app_translations.dart';

abstract class BaseScreen<T extends StatefulWidget> extends State<T> {
  String getString(String key) => AppTranslations.of(context).text(key);

  Widget baseScaffold(
      {String myTitle,
      @required Widget myBody,
      FloatingActionButton floatButton}) {
    return Scaffold(
      appBar: myTitle != null
          ? AppBar(
              backgroundColor: AppColors.mainColor,
              title: Text(getString(myTitle)),
            )
          : null,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanDown: (_) => FocusScope.of(context).unfocus(),
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(child: myBody),
      ),
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      floatingActionButton: floatButton,
    );
  }

  double getWidthPercen(int percen) {
    return (MediaQuery.of(context).size.width * percen) / 100;
  }

  double getHeightPercen(int percen) {
    return (MediaQuery.of(context).size.height * percen) / 100;
  }

  void popToScreen([dynamic params]) {
    Navigator.pop(context, params);
  }

  Future goToScreen(String screen, [dynamic params]) async {
    return await Navigator.of(context).pushNamed(screen, arguments: params);
  }

  Future goToAndRemoveScreen(String screen, [dynamic params]) async {
    return await Navigator.of(context).pushNamedAndRemoveUntil(
        screen, (Route<dynamic> route) => false,
        arguments: params);
  }
}
