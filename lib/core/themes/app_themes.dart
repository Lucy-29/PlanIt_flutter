import 'package:flutter/material.dart';

class AppThemes {
  static const Color _primary = Color(0xFF206173);
  static const Color _secondary = Color(0xFF50C878);

  final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF4F2EA),
    primaryColor: _primary,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFF4F2EA),
      iconTheme: IconThemeData(color: _primary, size: 30),
      titleTextStyle: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: _primary,
      ),
    ),
    iconTheme: const IconThemeData(color: _primary, size: 30),
    colorScheme: const ColorScheme.light(
      primary: _primary,
      secondary: _secondary,
      surface: Color(0xFFF4F2EA),
      onPrimary: Colors.white, // Text color on primary background
      onSurface: Colors.black, // Default text color on surface
    ),
    // 👇 ADD THIS NEW SECTION FOR TOGGLE BUTTONS (Light Mode)
    toggleButtonsTheme: ToggleButtonsThemeData(
      fillColor: _primary, // Background of selected button
      selectedColor: Colors.white, // Text color of selected button
      color: _primary, // Text color of UNselected button
      borderRadius: BorderRadius.circular(8),
      constraints: const BoxConstraints(minHeight: 36, minWidth: 50),
    ),
  );

  final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF192428),
    primaryColor: _primary,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF206173),
      elevation: 0,
      iconTheme: IconThemeData(color: Color(0xFFF4F2EA), size: 30),
      titleTextStyle: TextStyle(
        color: Color(0xFFF4F2EA),
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    ),
    iconTheme: const IconThemeData(color: Color(0xFFF4F2EA), size: 30),
    colorScheme: const ColorScheme.dark(
      primary: _primary,
      secondary: _secondary,
      surface: Color(0xFF2C3E45), // A slightly lighter dark for fields
      onPrimary: Colors.white, // Text color on primary background
      onSurface: Colors.white, // Default text color on surface
    ),
    // 👇 ADD THIS NEW SECTION FOR TOGGLE BUTTONS (Dark Mode)
    toggleButtonsTheme: ToggleButtonsThemeData(
      fillColor: _primary, // Background of selected button
      selectedColor: Colors.white, // Text color of selected button
      color: Colors.white70, // Text color of UNselected button (THE FIX!)
      borderRadius: BorderRadius.circular(8),
      constraints: const BoxConstraints(minHeight: 36, minWidth: 50),
    ),
  );
}
