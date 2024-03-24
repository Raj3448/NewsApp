import 'package:flutter/material.dart';

class AppTheme extends ChangeNotifier {
  AppTheme();
  static Color primaryColor = const Color.fromRGBO(17, 24, 39, 1);
  static Color secondaryColor = const Color(0xFFFaf9f6);
  static Color backgroundColor = Colors.white;

  static const String primaryFontFamily = 'MyUniqueFont';
  static TextStyle displayLarge = TextStyle(
      fontFamily: 'MyUniqueFont',
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: primaryColor);

  static TextStyle displayMedium = const TextStyle(
      fontFamily: 'MyUniqueFont',
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Color(0x883D3D3D));

  TextStyle copyWith(
      {String fontFamily = 'MyUniqueFont',
      double fontSize = 16,
      FontWeight fontWeight = FontWeight.w500,
      Color color = Colors.black54,
      TextOverflow? overflow}) {
    return TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        overflow: overflow);
  }

  get getPrimaryColor {
    return primaryColor;
  }

  get getsecondaryColor {
    return secondaryColor;
  }

  get getbackGround {
    return backgroundColor;
  }

  get getdisplayLarge {
    return displayLarge;
  }

  get getDisplayMedium {
    return displayMedium;
  }

  void toggleDark() {
    primaryColor = Colors.black45;
    backgroundColor = Colors.black87;
    displayLarge = const TextStyle(
        fontFamily: 'MyUniqueFont',
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white);
    displayMedium = const TextStyle(
        fontFamily: 'MyUniqueFont',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Color(0x883D3D3D));
    notifyListeners();
  }

  void toggleLight() {
    primaryColor = const Color.fromRGBO(17, 24, 39, 1);
    secondaryColor = const Color(0xFFFaf9f6);
    backgroundColor = Colors.white;
    displayLarge = TextStyle(
        fontFamily: 'MyUniqueFont',
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: primaryColor);
    displayMedium = const TextStyle(
        fontFamily: 'MyUniqueFont',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Color(0x883D3D3D));
    notifyListeners();
  }
}
