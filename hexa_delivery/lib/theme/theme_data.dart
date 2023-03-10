import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xff81ccd1),
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontWeight: FontWeight.w600,
    ),
  ),
  textTheme: const TextTheme(
    displayMedium: TextStyle(
      fontSize: 24,
      color: Colors.grey,
      fontWeight: FontWeight.w600,
    ),
  ),
  primaryColor: const Color(0xff81ccd1),
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        width: 1,
        color: Colors.black,
      ),
      borderRadius: BorderRadius.circular(20),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        width: 2,
        color: Color(0xff81ccd1),
      ),
      borderRadius: BorderRadius.circular(20),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        width: 1.5,
        color: Colors.red,
      ),
      borderRadius: BorderRadius.circular(20),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        width: 1.5,
        color: Colors.red,
      ),
      borderRadius: BorderRadius.circular(20),
    ),
    errorStyle: const TextStyle(
      fontSize: 14,
    ),
    floatingLabelStyle: const TextStyle(
      color: Colors.black,
    ),
  ),
);
