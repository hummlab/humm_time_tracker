import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Color palette - Deep Ocean theme
  static const Color primaryDark = Color(0xFF0A1628);
  static const Color surfaceDark = Color(0xFF0F1D32);
  static const Color cardDark = Color(0xFF162544);
  static const Color borderDark = Color(0xFF1E3A5F);

  static const Color primaryAccent = Color(0xFF00D9FF);
  static const Color secondaryAccent = Color(0xFF7C3AED);
  static const Color tertiaryAccent = Color(0xFFFF6B6B);
  static const Color successAccent = Color(0xFF10B981);
  static const Color warningAccent = Color(0xFFFBBF24);

  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);

  static final List<Color> projectColors = [
    const Color(0xFF6366F1),
    const Color(0xFF8B5CF6),
    const Color(0xFFEC4899),
    const Color(0xFFF43F5E),
    const Color(0xFFF97316),
    const Color(0xFFEAB308),
    const Color(0xFF22C55E),
    const Color(0xFF14B8A6),
    const Color(0xFF06B6D4),
    const Color(0xFF3B82F6),
  ];

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: primaryDark,
      colorScheme: const ColorScheme.dark(
        primary: primaryAccent,
        secondary: secondaryAccent,
        surface: surfaceDark,
        error: tertiaryAccent,
        onPrimary: primaryDark,
        onSecondary: textPrimary,
        onSurface: textPrimary,
        onError: textPrimary,
      ),
      textTheme: GoogleFonts.dmSansTextTheme(
        const TextTheme(
          displayLarge: TextStyle(fontSize: 48, fontWeight: FontWeight.w700, color: textPrimary, letterSpacing: -1.5),
          displayMedium: TextStyle(fontSize: 36, fontWeight: FontWeight.w600, color: textPrimary, letterSpacing: -0.5),
          displaySmall: TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: textPrimary),
          headlineMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: textPrimary),
          headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: textPrimary),
          titleLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: textPrimary),
          titleMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: textPrimary),
          bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: textSecondary),
          bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: textSecondary),
          bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: textMuted),
          labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: textPrimary),
        ),
      ),
      cardTheme: CardThemeData(
        color: cardDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: borderDark, width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: borderDark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: borderDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryAccent, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: tertiaryAccent),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        hintStyle: const TextStyle(color: textMuted),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryAccent,
          foregroundColor: primaryDark,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: textPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          side: const BorderSide(color: borderDark),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryAccent,
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: surfaceDark,
        selectedColor: primaryAccent.withValues(alpha: 0.2),
        disabledColor: surfaceDark,
        labelStyle: const TextStyle(color: textSecondary, fontSize: 13),
        secondaryLabelStyle: const TextStyle(color: primaryAccent, fontSize: 13),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: borderDark),
        ),
      ),
      dividerTheme: const DividerThemeData(color: borderDark, thickness: 1),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: textPrimary),
        iconTheme: IconThemeData(color: textPrimary),
      ),
      navigationRailTheme: const NavigationRailThemeData(
        backgroundColor: surfaceDark,
        selectedIconTheme: IconThemeData(color: primaryAccent),
        unselectedIconTheme: IconThemeData(color: textMuted),
        selectedLabelTextStyle: TextStyle(color: primaryAccent, fontWeight: FontWeight.w600),
        unselectedLabelTextStyle: TextStyle(color: textMuted),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: surfaceDark,
        selectedItemColor: primaryAccent,
        unselectedItemColor: textMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryAccent,
        foregroundColor: primaryDark,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: cardDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: cardDark,
        contentTextStyle: const TextStyle(color: textPrimary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static Color colorFromHex(String hex) {
    return Color(int.parse(hex.replaceFirst('#', '0xFF')));
  }
}
