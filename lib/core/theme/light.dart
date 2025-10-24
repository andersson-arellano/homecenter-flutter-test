import 'package:flutter/material.dart';

class AppTheme {
  static const Color _primaryColor = Color(0xFF005BAC); // Azul Homecenter
  static const Color _secondaryColor = Color(0xFFFFD100); // Amarillo Homecenter
  static const Color _surfaceColor = Color(0xFFF4F4F4); // Fondo claro
  static const Color _errorColor = Color(0xFFD32F2F); // Rojo para errores

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryColor,
        secondary: _secondaryColor,
        surface: _surfaceColor,
        error: _errorColor,
        brightness: Brightness.light,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
        scrolledUnderElevation: 1,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _secondaryColor,
        foregroundColor: Colors.black,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
      ),
    );
  }
}