import 'package:flutter/material.dart';

class Pallete {
  static const Color lightBackground = Color(0xFFFAF3E1);
  static const Color purple = Color(0xFF341F58);
  static const Color yellow = Color(0xFFFEC447);
  static const Color black = Color(0xFF000000);
  static const Color grey = Color(0xFF787878);
  static const Color white = Color(0xFFFFFFFF);
  static const Color lightPurple = Color(0xFF9747FF);
  static const Color lightBlue = Color(0xFF9BD3D0);
  static const Color lightOrage = Color(0xFFFECCB5);
  static const Color lightRed = Color(0xFFD28181);
  static const Color red = Color(0xFFF24822);

  static const Color green = Color(0xFF57A990);
}

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Pallete.lightBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: Pallete.lightBackground,
      centerTitle: false,
      titleTextStyle: TextStyle(
          fontFamily: 'Fixel',
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Pallete.black),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontFamily: 'Fixel'),
      bodyMedium: TextStyle(fontFamily: 'Fixel'),
      displayLarge: TextStyle(fontFamily: 'Fixel'),
      displayMedium: TextStyle(fontFamily: 'Fixel'),
      displaySmall: TextStyle(fontFamily: 'Fixel'),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.only(
        top: 16,
        bottom: 16,
        left: 24,
      ),
      fillColor: Pallete.lightBackground,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(
          width: 2.0,
          color: Pallete.black,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(
          width: 2.0,
          color: Pallete.grey,
        ),
      ),
      hintStyle: const TextStyle(
        fontFamily: 'Fixel',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Pallete.grey,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Pallete.white,
    ),
  );
}
