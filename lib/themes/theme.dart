import 'package:flutter/material.dart';

class AppColor {
  static Color kPrimary = const Color(0XFF1460F2);
  static Color kWhite = const Color(0XFFFFFFFF);
  static Color kBackground = const Color(0XFFFAFAFA);
  static Color kGrayscaleDark100 = const Color(0XFF1C1C1E);
  static Color kLine = const Color(0XFFEBEBEB);
  static Color kBackground2 = const Color(0XFFF6F6F6);
  static Color kGrayscale40 = const Color(0XFFAEAEB2);
  static Color bgColor = const Color(0xFF673AB7);
  static Color bgColor1 = const Color(0xFF6961B6);
  static Color button = const Color(0xFF2A6CD9);
}

final lightColorScheme = ColorScheme.light(
  primary: Colors.deepPurple,
  primaryContainer: Colors.deepPurpleAccent,
  secondary: Colors.amber,
  secondaryContainer: Colors.amberAccent,
  surface: Colors.white,
  background: Colors.grey[200]!,
  error: Colors.red,
  onPrimary: Colors.white,
  onSecondary: Colors.black,
  onSurface: Colors.black,
  onBackground: Colors.black,
  onError: Colors.white,
);

final darkColorScheme = ColorScheme.dark(
  primary: Colors.deepPurple,
  primaryContainer: Colors.deepPurpleAccent,
  secondary: Colors.amber,
  secondaryContainer: Colors.amberAccent,
  surface: Colors.grey[850]!,
  background: Colors.black,
  error: Colors.redAccent,
  onPrimary: Colors.black,
  onSecondary: Colors.black,
  onSurface: Colors.white,
  onBackground: Colors.white,
  onError: Colors.black,
);
