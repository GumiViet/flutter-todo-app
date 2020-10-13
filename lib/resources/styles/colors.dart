
import 'package:flutter/material.dart';

class AppColors {
  static var mainColor = HexColor("#ED1C24");
  static var white = HexColor('#FFFFFF');
  static var black = HexColor('#000000');

  static var mediumGray = HexColor('#797777');
  static var mediumBlue = HexColor('#5698D9');

  static var lightBlue = HexColor('#5997E0');
  static var lightGray = HexColor('#D0D0D0');
  static var lightBrown = HexColor('#F27777');
  static var lightGreen = HexColor('#46BEAB');
  static var lightOrange = HexColor('#F5DA8F');
  static var lightPink = HexColor('#DE446E');

  static var lightBlueBlur = HexColor('#B6D5F5');
  static var lightGrayBlur = HexColor('#E3E3E3');

  static var darkBrown = HexColor('#D1AD4A');
  static var darkRed = HexColor('#C45959');
}

// Parse hex to color.
class HexColor extends Color {
  static int _getColorFromHex(hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(value) : super(_getColorFromHex(value));
}
