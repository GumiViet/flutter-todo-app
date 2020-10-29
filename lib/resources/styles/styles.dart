import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_to_do/resources/styles/colors.dart';
import 'package:flutter_to_do/resources/styles/fonts.dart';

class AppStyles {
  static var mainTheme = ThemeData(
    primaryColor: AppColors.mainColor,
    accentColor: AppColors.mainColor,
    platform: TargetPlatform.iOS,
    scaffoldBackgroundColor: AppColors.white,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
    ),
    fontFamily: AppFonts.typeRegular,
  );

  TextStyle grayBold(double size) {
    return TextStyle(
        color: AppColors.lightGray,
        fontSize: size,
        fontFamily: AppFonts.typeBold);
  }

  TextStyle whiteRegular(double size) {
    return TextStyle(
      color: AppColors.white,
      fontSize: size,
    );
  }

  TextStyle blackRegular(double size) {
    return TextStyle(
      fontSize: size,
      color: AppColors.black,
    );
  }

  TextStyle lightGrayRegular(double size) {
    return TextStyle(
      fontSize: size,
      color: AppColors.lightGray,
    );
  }

  TextStyle lightBrownRegular(double size) {
    return TextStyle(
      fontSize: size,
      color: AppColors.lightBrown,
    );
  }

  TextStyle lightOrangeRegular(double size) {
    return TextStyle(
      fontSize: size,
      color: AppColors.lightOrange,
    );
  }

  TextStyle darkBrownRegular(double size) {
    return TextStyle(
      fontSize: size,
      color: AppColors.darkBrown,
    );
  }

  TextStyle colorTextDefaultRegular(double size) {
    return TextStyle(
      fontSize: size,
      color: AppColors.colorTextDefault,
    );
  }

  TextStyle colorTextDefaultBold(double size) {
    return TextStyle(
      fontSize: size,
      color: AppColors.colorTextDefault,
      fontFamily: AppFonts.typeBold,
    );
  }
}
