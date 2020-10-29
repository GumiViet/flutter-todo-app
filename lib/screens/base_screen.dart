import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_to_do/@shared/utils/utils.dart';
import 'package:flutter_to_do/resources/localization/langs.dart';
import 'package:flutter_to_do/resources/styles/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class BaseScreen<T extends StatefulWidget> extends State<T> {
  String getStringById(String key) => getString(context, key);

  double getHeightWithPercent(int per) =>
      (MediaQuery.of(context).size.height / 100) * per;

  double getWidthWithPercent(int per) =>
      (MediaQuery.of(context).size.width / 100) * per;

  void showToast(String content) =>
      EasyLoading.showToast(getStringById(content));

  void showLoading([String content]) => EasyLoading.show(
      status: content != null
          ? getStringById(content)
          : getStringById(AppLangs.text_loading));

  void dismissLoading() => EasyLoading.dismiss();

  Widget lineVertical(double width, [HexColor color]) => Container(
        color: color ?? AppColors.lightGray,
        width: double.infinity,
        height: width,
      );

  Widget lineHorizontal(double width, [HexColor color]) => Container(
        color: color ?? AppColors.lightGray,
        width: double.infinity,
        height: width,
      );

  Widget baseScaffold(
      {String myTitle,
      @required Widget myBody,
      FloatingActionButton floatButton}) {
    return SafeArea(
      child: Scaffold(
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
          child: myBody,
        ),
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        floatingActionButton: floatButton,
      ),
    );
  }
}
