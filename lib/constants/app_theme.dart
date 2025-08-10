import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme_extensions.dart';

class AppThemeData {
  static const _lightFillColor = Colors.black;
  static const _darkFillColor = Colors.white;

  static final Color _lightFocusColor = Colors.black.withValues(alpha: 0.12);
  static final Color _darkFocusColor = Colors.white.withValues(alpha: 0.12);

  static ThemeData lightThemeData = themeData(lightColorScheme,
      _lightFocusColor, CategoryColors.light, ExerciseColors.light);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor,
      CategoryColors.dark, ExerciseColors.dark);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor,
      CategoryColors categoryColors, ExerciseColors exerciseColors) {
    return ThemeData(
      colorScheme: colorScheme,
      textTheme: _textTheme,
      // Matches manifest.json colors and background color.
      primaryColor: const Color(0xFF030303),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.primary),
      ),
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
      canvasColor: colorScheme.surface,
      scaffoldBackgroundColor: colorScheme.surface,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.alphaBlend(
          _lightFillColor.withValues(alpha: 0.80),
          _darkFillColor,
        ),
        contentTextStyle: _textTheme.titleMedium!.apply(color: _darkFillColor),
      ),
      extensions: <ThemeExtension<dynamic>>[categoryColors, exerciseColors],
    );
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xFF1E7D55), // Emerald Green
    primaryContainer: Color(0xFF165c41), // Darker Emerald Green
    secondary: Color(0xFF2D8C8C), // Deep Turquoise
    secondaryContainer: Color(0xFF226b6b), // Darker Deep Turquoise
    surface: Color(0xFFFAF9F5), // Ivory White
    error: Color(0xFFC0392B), // Pomegranate Red
    onPrimary: Color(0xFFFAF9F5), // Ivory White
    onSecondary: Color(0xFFFAF9F5), // Ivory White
    onSurface: Color(0xFF333333), // Charcoal Gray
    onError: Color(0xFFFAF9F5), // Ivory White
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color(0xFF26a269), // Lighter Emerald Green
    primaryContainer: Color(0xFF1E7D55), // Emerald Green
    secondary: Color(0xFF4DB6AC), // Lighter Deep Turquoise
    secondaryContainer: Color(0xFF2D8C8C), // Deep Turquoise
    surface: Color(0xFF333333), // Charcoal Gray
    error: Color(0xFFE57373), // Lighter Pomegranate Red
    onPrimary: Color(0xFF121212),
    onSecondary: Color(0xFF121212),
    onSurface: Color(0xFFFAF9F5), // Ivory White
    onError: Color(0xFF121212),
    brightness: Brightness.dark,
  );

  static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _semiBold = FontWeight.w600;
  static const _bold = FontWeight.w700;

  static final TextTheme _textTheme = TextTheme(
    headlineMedium: GoogleFonts.montserrat(fontWeight: _bold, fontSize: 20.0),
    bodySmall: GoogleFonts.oswald(fontWeight: _semiBold, fontSize: 16.0),
    headlineSmall: GoogleFonts.oswald(fontWeight: _medium, fontSize: 16.0),
    titleMedium: GoogleFonts.montserrat(fontWeight: _medium, fontSize: 16.0),
    labelSmall: GoogleFonts.montserrat(fontWeight: _medium, fontSize: 12.0),
    bodyLarge: GoogleFonts.montserrat(fontWeight: _regular, fontSize: 14.0),
    titleSmall: GoogleFonts.montserrat(fontWeight: _medium, fontSize: 14.0),
    bodyMedium: GoogleFonts.montserrat(fontWeight: _regular, fontSize: 16.0),
    titleLarge: GoogleFonts.montserrat(fontWeight: _bold, fontSize: 16.0),
    labelLarge: GoogleFonts.montserrat(fontWeight: _semiBold, fontSize: 14.0),
  );
}
