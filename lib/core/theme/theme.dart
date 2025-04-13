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
    onSecondary: Color(0xFF4A4A4A),
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
      fontSize: 48, //! Unused
      fontWeight: FontWeight.w700,
    ),
    displayMedium: GoogleFonts.fredoka(
      fontSize: 36,
      fontWeight: FontWeight.w700,
    ),
    displaySmall: GoogleFonts.fredoka(
      fontSize: 24,
      fontWeight: FontWeight.w700,
    ),
    headlineLarge: GoogleFonts.fredoka(
      fontSize: 32, //! Unused
      fontWeight: FontWeight.w700,
    ),
    headlineMedium: GoogleFonts.fredoka(
      fontSize: 26, //! Unused
      fontWeight: FontWeight.w700,
    ),
    headlineSmall: GoogleFonts.fredoka(
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    titleLarge: GoogleFonts.fredoka(fontSize: 25, fontWeight: FontWeight.w600),
    titleMedium: GoogleFonts.fredoka(fontSize: 20, fontWeight: FontWeight.w600),
    titleSmall: GoogleFonts.fredoka(fontSize: 18),
    bodyLarge: GoogleFonts.fredoka(fontSize: 20),
    bodyMedium: GoogleFonts.fredoka(fontSize: 16),
    bodySmall: GoogleFonts.fredoka(fontSize: 14),
    labelLarge: GoogleFonts.fredoka(fontSize: 12), //! Unused
    labelMedium: GoogleFonts.fredoka(fontSize: 11), //! Unused
    labelSmall: GoogleFonts.fredoka(fontSize: 10), //! Unused
  ),

  // AppBar Theme
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    foregroundColor: Colors.white,
    backgroundColor: Color(0xFF5CB15A),
    iconTheme: IconThemeData(size: 32, color: Colors.white),
    shadowColor: Color(0xFF4A4A4A),
  ),

  // ElevatedButton Theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF5CB15A),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: GoogleFonts.fredoka(
        fontWeight: FontWeight.w600,
        fontSize: 25,
        color: Colors.white,
      ),
    ),
  ),

  // FloatingActionButton Theme
  floatingActionButtonTheme: const FloatingActionButtonThemeData(iconSize: 32),
);
