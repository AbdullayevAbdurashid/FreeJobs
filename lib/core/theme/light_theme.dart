import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  fontFamily: 'Ubuntu',
  primaryColor: Color(0xFF056AB4),
  primaryColorLight: Color(0xFFF0F4F8),
  primaryColorDark: Color(0xFF10324A),
  secondaryHeaderColor: Color(0xFF758493),

  disabledColor: Color(0xFF8797AB),
  scaffoldBackgroundColor: Color(0xFFFFFFFF),
  brightness: Brightness.light,
  hintColor: Color(0xFFC0BFBF),
  focusColor: Color(0xFFFFF9E5),
  hoverColor: Color(0xFFF1F7FC),
  shadowColor: Colors.grey[300],
  cardColor: Colors.white,
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: Color(0xFF0461A5))),
  colorScheme: ColorScheme.light(
    primary: Color(0xFF056AB4),
    secondary: Color(0xFFFF9900),
    tertiary: Color(0xFFd35221),
    onSecondaryContainer: Color(0xFF02AA05),
    error: Color(0xffed4f55)
  ).copyWith(background: Color(0xffFCFCFC)),
);