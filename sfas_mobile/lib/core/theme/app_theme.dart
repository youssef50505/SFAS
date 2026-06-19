import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // NTG Red Corporate Color
  static const Color ntgRed = Color(0xFFc8102e);
  static const Color backgroundLight = Color(0xFFf8fafc);
  static const Color backgroundDark = Color(0xFF0f172a);
  static const Color surfaceLight = Colors.white;
  static const Color surfaceDark = Color(0xFF1e293b);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: ntgRed,
        secondary: ntgRed.withOpacity(0.8),
        background: backgroundLight,
        surface: surfaceLight,
        onPrimary: Colors.white,
      ),
      scaffoldBackgroundColor: backgroundLight,
      textTheme: TextTheme(
        displayLarge: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: Colors.black87),
        displayMedium: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: Colors.black87),
        displaySmall: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: Colors.black87),
        headlineMedium: GoogleFonts.outfit(fontWeight: FontWeight.w600, color: Colors.black87),
        bodyLarge: GoogleFonts.inter(color: Colors.black87),
        bodyMedium: GoogleFonts.inter(color: Colors.black87),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: surfaceLight,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.black87),
        titleTextStyle: TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w600),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ntgRed,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: ntgRed,
        secondary: ntgRed.withOpacity(0.8),
        background: backgroundDark,
        surface: surfaceDark,
        onPrimary: Colors.white,
      ),
      scaffoldBackgroundColor: backgroundDark,
      textTheme: TextTheme(
        displayLarge: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: Colors.white),
        displayMedium: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: Colors.white),
        displaySmall: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: Colors.white),
        headlineMedium: GoogleFonts.outfit(fontWeight: FontWeight.w600, color: Colors.white),
        bodyLarge: GoogleFonts.inter(color: Colors.white70),
        bodyMedium: GoogleFonts.inter(color: Colors.white70),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: surfaceDark,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ntgRed,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        ),
      ),
    );
  }
}
