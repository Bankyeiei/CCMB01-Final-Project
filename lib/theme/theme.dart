import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData themeData = ThemeData(
  // Primary Color
  primaryColor: const Color(0xFF5CB15A),

  // Color Scheme
  colorScheme: const ColorScheme(
    primary: Color(0xFF5CB15A),
    onPrimary: Colors.white,
    secondary: Color(0xFFD4D4D4),
    onSecondary: Colors.black,
    surface: Colors.white,
    onSurface: Colors.black,
    error: Color(0xFFE54D4D),
    onError: Colors.white,
    brightness: Brightness.light,
  ),

  scaffoldBackgroundColor: Colors.white,

  // Text Theme using Fredoka font
  useMaterial3: true,
  textTheme: TextTheme(
    displayLarge: GoogleFonts.fredoka(
      fontSize: 57,
      fontWeight: FontWeight.w700,
    ),
    displayMedium: GoogleFonts.fredoka(
      fontSize: 45,
      fontWeight: FontWeight.w600,
    ),
    displaySmall: GoogleFonts.fredoka(
      fontSize: 36,
      fontWeight: FontWeight.w500,
    ),
    headlineLarge: GoogleFonts.fredoka(
      fontSize: 32,
      fontWeight: FontWeight.w700,
    ),
    headlineMedium: GoogleFonts.fredoka(
      fontSize: 28,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: GoogleFonts.fredoka(
      fontSize: 24,
      fontWeight: FontWeight.w600,
    ),
    titleLarge: GoogleFonts.fredoka(fontSize: 22, fontWeight: FontWeight.w600),
    titleMedium: GoogleFonts.fredoka(fontSize: 18, fontWeight: FontWeight.w600),
    titleSmall: GoogleFonts.fredoka(fontSize: 14, fontWeight: FontWeight.w500),
    bodyLarge: GoogleFonts.fredoka(fontSize: 16, fontWeight: FontWeight.w400),
    bodyMedium: GoogleFonts.fredoka(fontSize: 14, fontWeight: FontWeight.w400),
    bodySmall: GoogleFonts.fredoka(fontSize: 12, fontWeight: FontWeight.w400),
    labelLarge: GoogleFonts.fredoka(fontSize: 14, fontWeight: FontWeight.w500),
    labelMedium: GoogleFonts.fredoka(fontSize: 12, fontWeight: FontWeight.w500),
    labelSmall: GoogleFonts.fredoka(fontSize: 11, fontWeight: FontWeight.w400),
  ),

  // ElevatedButton Theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF5CB15A),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: GoogleFonts.fredoka(fontWeight: FontWeight.w600, fontSize: 16),
    ),
  ),
);
