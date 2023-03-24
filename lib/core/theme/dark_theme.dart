import 'package:flutter/material.dart';

ThemeData dark = ThemeData(
  fontFamily: 'Ubuntu',
  primaryColor: Color(0xFF010D15),
  primaryColorLight: Color(0xFFF0F4F8),
  primaryColorDark: Color(0xFF10324A),
  backgroundColor: Color(0xff010D15),
  secondaryHeaderColor: Color(0xFF9BB8DA),

  disabledColor: Color(0xFF8797AB),
  scaffoldBackgroundColor: Color(0xFF151515),
  errorColor: Color(0xFFdd3135),
  brightness: Brightness.dark,
  hintColor: Color(0xFFC0BFBF),
  focusColor: Color(0xFF484848),
  hoverColor: Color(0x400461A5),
  shadowColor: Color(0x33e2f1ff),
  cardColor: Color(0xFF10324A),
  colorScheme: ColorScheme.dark(
      primary: Color(0xFF056AB4),
      secondary: Color(0xFFf57d00),
      tertiary: (Color(0xFFFF6767) ),
      onPrimary: Color(0xff1c3c5d),
  ),
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: Color(0xFFFFFFFF))),
);

// semi-dark-light-color