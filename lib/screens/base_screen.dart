import 'package:flutter/material.dart';
import 'package:flutter_to_do/@shared/utils/utils.dart';
import 'package:flutter_to_do/resources/styles/colors.dart';

abstract class BaseScreen<T extends StatefulWidget> extends State<T> {
  String getStringById(String key) => getString(context, key);

  double getHeightWithPercent(int per) =>
      (MediaQuery.of(context).size.height / 100) * per;

  double getWidthWithPercent(int per) =>
      (MediaQuery.of(context).size.width /  100) * per;

  Widget baseScaffold(
      {String myTitle,
      @required Widget myBody,
      FloatingActionButton floatButton}) {
    return Scaffold(
      appBar: myTitle != null
          ? AppBar(
              backgroundColor: AppColors.mainColor,
              title: Text(getStringById(myTitle)),
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
}
