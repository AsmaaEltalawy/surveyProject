import 'package:flutter/material.dart';

class ApplicationTheme{
  static Color primaryLight=Colors.black;
  static Color white=Colors.white;
  static ThemeData lightMode=ThemeData(
  primaryColor: primaryLight,
  colorScheme: ColorScheme.fromSeed(primary: primaryLight,seedColor: primaryLight,onSecondary:primaryLight ),
  appBarTheme: const AppBarTheme(
  backgroundColor: Colors.transparent,
  elevation: 0,
  iconTheme: IconThemeData(
  color: Colors.black
  ),
  titleTextStyle: TextStyle(
  color: Colors.white,fontWeight: FontWeight.bold,fontSize: 28
  )
  ),
    textTheme: TextTheme(
        titleLarge: TextStyle(
          color: Colors.black,fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold,fontSize: 16),
        bodyMedium: TextStyle(fontSize: 28,fontWeight: FontWeight.bold,color: Colors.black),
        bodyLarge: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.w800),
        bodySmall: TextStyle(fontSize: 26,color: Colors.white,fontWeight: FontWeight.w300)
    ),
  );
}