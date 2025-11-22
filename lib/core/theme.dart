import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color navy = Color(0xFF001A43);
  static const Color red = Color(0xFFE10600);
  static const Color white = Color(0xFFFFFFFF);
  static const Color beige = Color(0xFFF5F5DC); // Baguette color
  static const Color lightGrey = Color(0xFFF0F2F5);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: navy,
        primary: navy,
        secondary: red,
        surface: white,
        background: lightGrey,
      ),
      scaffoldBackgroundColor: lightGrey,
      textTheme: GoogleFonts.outfitTextTheme().apply(
        bodyColor: navy,
        displayColor: navy,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: white,
        foregroundColor: navy,
        elevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: navy,
          foregroundColor: white,
          textStyle: GoogleFonts.outfit(fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
