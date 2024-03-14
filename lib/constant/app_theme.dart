import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme();
  static const Color primaryColor = Color.fromRGBO(17, 24, 39, 1);
  static const Color secondaryColor = Color(0xFFFaf9f6);

  static const String primaryFontFamily = 'MyUniqueFont';
  static const TextStyle displayLarge = TextStyle(
      fontFamily: 'MyUniqueFont',
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: primaryColor);

  static const TextStyle displayMedium = TextStyle(
      fontFamily: 'MyUniqueFont',
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Color(0x883D3D3D));

  static TextStyle copyWith(
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
}