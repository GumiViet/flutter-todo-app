
import 'package:flutter/material.dart';

class AppColors {
  static var mainColor = HexColor("#ED1C24");
  static var appScreenBackground = HexColor("#F2F3F3");
  static var grayMedium = HexColor('#d0d0d0');
  static var white = HexColor('#FFFFFF');
  static var black = HexColor('#000000');
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
