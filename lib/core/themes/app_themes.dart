import 'package:flutter/material.dart';

class AppThemes {
  final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xFFF4F2EA),
    primaryColor: Color(0xFF206173),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFFF4F2EA),
      iconTheme: IconThemeData(
        color: Color(0xFF206173),
        size: 30,
      ),
      titleTextStyle: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Color(0xFF206173),
      ),
    ),

    colorScheme: ColorScheme.light(
      primary: Color(0xFF206173),
      secondary: Color(0xFF50C878),
      background: Color(0xFFF4F2EA),
      // surface: ,
    ),
    // iconTheme: IconThemeData(color: Color(0xFF206173)),
  );
  final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xFF192428),
    primaryColor: const Color(0xFF206173),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF206173),
      elevation: 0,
      iconTheme: IconThemeData(
        color: Color(0xFFF4F2EA),
        size: 30,
      ),
      titleTextStyle: TextStyle(
        color: Color(0xFFF4F2EA),
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
    ),
    colorScheme: ColorScheme.dark(
      primary: Colors.white,
      background: Color(0xFF192428),
      // surface: Color(0xFF2C3E45),
    ),
    // iconTheme: IconThemeData(color: Colors.tealAccent),
  );
}
