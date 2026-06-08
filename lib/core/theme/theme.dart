import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// COLORES
// ─────────────────────────────────────────
class AppColors {
  AppColors._();

  static const Color bg        = Color(0xFF292824);
  static const Color surface   = Color(0xFF64584A);
  static const Color muted     = Color(0xFFA29783);
  static const Color gold      = Color(0xFFD5B880);
  static const Color crimson   = Color(0xFF934538);

  static const Color goldDim   = Color(0x26D5B880); // gold al 15%
  static const Color goldLine  = Color(0x59D5B880); // gold al 35%
  static const Color onDark    = Color(0xFFF5E8CB); // texto claro sobre crimson
}

// TIPOGRAFÍA
// ─────────────────────────────────────────
class AppTextStyles {
  AppTextStyles._();

  // Playfair Display — títulos y números prominentes
  static TextStyle displayLarge() => GoogleFonts.playfairDisplay(
    fontSize: 42,
    fontWeight: FontWeight.w900,
    color: AppColors.gold,
    height: 1.0,
  );

  static TextStyle displayMedium() => GoogleFonts.playfairDisplay(
    fontSize: 32,
    fontWeight: FontWeight.w900,
    color: AppColors.gold,
    letterSpacing: 0.02,
  );

  static TextStyle titleLarge() => GoogleFonts.playfairDisplay(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.gold,
  );

  // Cormorant Garamond — subtítulos y texto de apoyo
  static TextStyle bodyLarge() => GoogleFonts.cormorantGaramond(
    fontSize: 17,
    fontWeight: FontWeight.w300,
    fontStyle: FontStyle.italic,
    color: AppColors.muted,
    height: 1.6,
  );

  static TextStyle bodyMedium() => GoogleFonts.cormorantGaramond(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    color: AppColors.muted,
    letterSpacing: 0.05,
  );

  // Josefin Sans — etiquetas, navegación, badges
  static TextStyle labelLarge() => GoogleFonts.josefinSans(
    fontSize: 10,
    fontWeight: FontWeight.w300,
    color: AppColors.gold,
    letterSpacing: 0.40,
  );

  static TextStyle labelMedium() => GoogleFonts.josefinSans(
    fontSize: 9,
    fontWeight: FontWeight.w300,
    color: AppColors.muted,
    letterSpacing: 0.30,
  );

  static TextStyle labelSmall() => GoogleFonts.josefinSans(
    fontSize: 8,
    fontWeight: FontWeight.w100,
    color: AppColors.muted,
    letterSpacing: 0.35,
  );
}

// ─────────────────────────────────────────
// TEMA PRINCIPAL
// ─────────────────────────────────────────

class AppTheme {
  AppTheme._();

  static ThemeData get theme => ThemeData(
    useMaterial3: true,

    colorScheme: const ColorScheme(
      brightness: Brightness.dark,

      // Primarios
      primary:          AppColors.gold,
      onPrimary:        AppColors.bg,

      // Secundarios
      secondary:        AppColors.surface,
      onSecondary:      AppColors.gold,

      // Superficies
      surface:          AppColors.bg,
      onSurface:        AppColors.gold,

      // Errores / estados negativos
      error:            AppColors.crimson,
      onError:          AppColors.onDark,

      // Variantes de superficie
      surfaceContainerHighest: AppColors.surface,
      onSurfaceVariant:        AppColors.muted,

      // Contornos
      outline:         AppColors.goldLine,
      outlineVariant:  AppColors.goldDim,
    ),

    textTheme: TextTheme(
      displayLarge:  AppTextStyles.displayLarge(),
      displayMedium: AppTextStyles.displayMedium(),
      titleLarge:    AppTextStyles.titleLarge(),
      bodyLarge:     AppTextStyles.bodyLarge(),
      bodyMedium:    AppTextStyles.bodyMedium(),
      labelLarge:    AppTextStyles.labelLarge(),
      labelMedium:   AppTextStyles.labelMedium(),
      labelSmall:    AppTextStyles.labelSmall(),
    ),

    scaffoldBackgroundColor: AppColors.bg,

    appBarTheme: AppBarTheme(
      backgroundColor:  AppColors.bg,
      foregroundColor:  AppColors.gold,
      elevation:        0,
      centerTitle:      true,
      titleTextStyle:   AppTextStyles.displayMedium().copyWith(fontSize: 22),
    ),

    dividerTheme: const DividerThemeData(
      color:     AppColors.goldLine,
      thickness: 1,
      space:     0,
    ),

    cardTheme: CardThemeData(
      color:        AppColors.goldDim,
      elevation:    0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: const BorderSide(color: AppColors.goldLine, width: 1),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor:   Colors.transparent,
        foregroundColor:   AppColors.gold,
        side:              const BorderSide(color: AppColors.gold, width: 1),
        shape:             const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        padding:           const EdgeInsets.symmetric(vertical: 14),
        textStyle:         AppTextStyles.labelLarge(),
        elevation:         0,
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor:      AppColors.bg,
      selectedItemColor:    AppColors.gold,
      unselectedItemColor:  AppColors.surface,
      selectedLabelStyle:   AppTextStyles.labelSmall(),
      unselectedLabelStyle: AppTextStyles.labelSmall(),
      elevation:            0,
      type:                 BottomNavigationBarType.fixed,
    ),
  );
}