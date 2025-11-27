import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'tokens.dart';

/// Material 3 Theme Configuration for ProxyGSM
class AppTheme {
  // ============================================
  // LIGHT THEME
  // ============================================

  static ThemeData lightTheme() {
    final ColorScheme colorScheme = const ColorScheme.light(
      primary: AppTokens.lightPrimary,
      onPrimary: AppTokens.lightOnPrimary,
      primaryContainer: AppTokens.lightPrimaryContainer,
      onPrimaryContainer: AppTokens.lightOnPrimaryContainer,
      secondary: AppTokens.lightSecondary,
      onSecondary: AppTokens.lightOnSecondary,
      secondaryContainer: AppTokens.lightSecondaryContainer,
      onSecondaryContainer: AppTokens.lightOnSecondaryContainer,
      tertiary: AppTokens.lightTertiary,
      onTertiary: AppTokens.lightOnTertiary,
      tertiaryContainer: AppTokens.lightTertiaryContainer,
      onTertiaryContainer: AppTokens.lightOnTertiaryContainer,
      error: AppTokens.lightError,
      onError: AppTokens.lightOnError,
      errorContainer: AppTokens.lightErrorContainer,
      onErrorContainer: AppTokens.lightOnErrorContainer,
      surface: AppTokens.lightSurface,
      onSurface: AppTokens.lightOnSurface,
      surfaceContainerHighest: AppTokens.lightSurfaceVariant,
      onSurfaceVariant: AppTokens.lightOnSurfaceVariant,
      outline: AppTokens.lightOutline,
      outlineVariant: AppTokens.lightOutlineVariant,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,

      // Typography with Google Fonts
      textTheme: GoogleFonts.interTextTheme(_buildTextTheme(colorScheme)),

      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface,
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusMd),
        ),
        color: colorScheme.surfaceContainerHighest,
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.space6,
            vertical: AppTokens.space4,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTokens.radiusLg),
          ),
          minimumSize: const Size(64, AppTokens.touchTargetMin),
        ),
      ),

      // Filled Button Theme
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.space6,
            vertical: AppTokens.space4,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTokens.radiusLg),
          ),
          minimumSize: const Size(64, AppTokens.touchTargetMin),
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.space4,
            vertical: AppTokens.space3,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTokens.radiusMd),
          ),
          minimumSize: const Size(64, AppTokens.touchTargetMin),
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.space6,
            vertical: AppTokens.space4,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTokens.radiusLg),
          ),
          side: BorderSide(color: colorScheme.outline),
          minimumSize: const Size(64, AppTokens.touchTargetMin),
        ),
      ),

      // Icon Button Theme
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          minimumSize: const Size(
            AppTokens.touchTargetMin,
            AppTokens.touchTargetMin,
          ),
        ),
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 3,
        highlightElevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusLg),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusMd),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusMd),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusMd),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusMd),
          borderSide: BorderSide(color: colorScheme.error),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppTokens.space4,
          vertical: AppTokens.space4,
        ),
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusXl),
        ),
        backgroundColor: colorScheme.surface,
      ),

      // Bottom Sheet Theme
      bottomSheetTheme: BottomSheetThemeData(
        elevation: 3,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppTokens.radiusXl),
          ),
        ),
        backgroundColor: colorScheme.surface,
      ),

      // Navigation Bar Theme
      navigationBarTheme: NavigationBarThemeData(
        elevation: 0,
        backgroundColor: colorScheme.surface,
        indicatorColor: colorScheme.secondaryContainer,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurface,
            );
          }
          return GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: colorScheme.onSurfaceVariant,
          );
        }),
      ),

      // Navigation Rail Theme
      navigationRailTheme: NavigationRailThemeData(
        elevation: 0,
        backgroundColor: colorScheme.surface,
        selectedIconTheme: IconThemeData(
          color: colorScheme.onSecondaryContainer,
        ),
        unselectedIconTheme: IconThemeData(color: colorScheme.onSurfaceVariant),
        selectedLabelTextStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface,
        ),
        unselectedLabelTextStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurfaceVariant,
        ),
      ),

      // Divider Theme
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        thickness: 1,
        space: 1,
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surfaceContainerHighest,
        deleteIconColor: colorScheme.onSurfaceVariant,
        disabledColor: colorScheme.onSurface.withOpacity(0.12),
        selectedColor: colorScheme.secondaryContainer,
        secondarySelectedColor: colorScheme.secondaryContainer,
        padding: const EdgeInsets.symmetric(
          horizontal: AppTokens.space3,
          vertical: AppTokens.space2,
        ),
        labelStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        secondaryLabelStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusMd),
        ),
      ),
    );
  }

  // ============================================
  // DARK THEME
  // ============================================

  static ThemeData darkTheme() {
    final ColorScheme colorScheme = const ColorScheme.dark(
      primary: AppTokens.darkPrimary,
      onPrimary: AppTokens.darkOnPrimary,
      primaryContainer: AppTokens.darkPrimaryContainer,
      onPrimaryContainer: AppTokens.darkOnPrimaryContainer,
      secondary: AppTokens.darkSecondary,
      onSecondary: AppTokens.darkOnSecondary,
      secondaryContainer: AppTokens.darkSecondaryContainer,
      onSecondaryContainer: AppTokens.darkOnSecondaryContainer,
      tertiary: AppTokens.darkTertiary,
      onTertiary: AppTokens.darkOnTertiary,
      tertiaryContainer: AppTokens.darkTertiaryContainer,
      onTertiaryContainer: AppTokens.darkOnTertiaryContainer,
      error: AppTokens.darkError,
      onError: AppTokens.darkOnError,
      errorContainer: AppTokens.darkErrorContainer,
      onErrorContainer: AppTokens.darkOnErrorContainer,
      surface: AppTokens.darkSurface,
      onSurface: AppTokens.darkOnSurface,
      surfaceContainerHighest: AppTokens.darkSurfaceVariant,
      onSurfaceVariant: AppTokens.darkOnSurfaceVariant,
      outline: AppTokens.darkOutline,
      outlineVariant: AppTokens.darkOutlineVariant,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,

      // Typography with Google Fonts
      textTheme: GoogleFonts.interTextTheme(_buildTextTheme(colorScheme)),

      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface,
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusMd),
        ),
        color: colorScheme.surfaceContainerHighest,
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.space6,
            vertical: AppTokens.space4,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTokens.radiusLg),
          ),
          minimumSize: const Size(64, AppTokens.touchTargetMin),
        ),
      ),

      // Filled Button Theme
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.space6,
            vertical: AppTokens.space4,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTokens.radiusLg),
          ),
          minimumSize: const Size(64, AppTokens.touchTargetMin),
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.space4,
            vertical: AppTokens.space3,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTokens.radiusMd),
          ),
          minimumSize: const Size(64, AppTokens.touchTargetMin),
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.space6,
            vertical: AppTokens.space4,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTokens.radiusLg),
          ),
          side: BorderSide(color: colorScheme.outline),
          minimumSize: const Size(64, AppTokens.touchTargetMin),
        ),
      ),

      // Icon Button Theme
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          minimumSize: const Size(
            AppTokens.touchTargetMin,
            AppTokens.touchTargetMin,
          ),
        ),
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 3,
        highlightElevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusLg),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusMd),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusMd),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusMd),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusMd),
          borderSide: BorderSide(color: colorScheme.error),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppTokens.space4,
          vertical: AppTokens.space4,
        ),
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusXl),
        ),
        backgroundColor: colorScheme.surface,
      ),

      // Bottom Sheet Theme
      bottomSheetTheme: BottomSheetThemeData(
        elevation: 3,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppTokens.radiusXl),
          ),
        ),
        backgroundColor: colorScheme.surface,
      ),

      // Navigation Bar Theme
      navigationBarTheme: NavigationBarThemeData(
        elevation: 0,
        backgroundColor: colorScheme.surface,
        indicatorColor: colorScheme.secondaryContainer,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurface,
            );
          }
          return GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: colorScheme.onSurfaceVariant,
          );
        }),
      ),

      // Navigation Rail Theme
      navigationRailTheme: NavigationRailThemeData(
        elevation: 0,
        backgroundColor: colorScheme.surface,
        selectedIconTheme: IconThemeData(
          color: colorScheme.onSecondaryContainer,
        ),
        unselectedIconTheme: IconThemeData(color: colorScheme.onSurfaceVariant),
        selectedLabelTextStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface,
        ),
        unselectedLabelTextStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurfaceVariant,
        ),
      ),

      // Divider Theme
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        thickness: 1,
        space: 1,
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surfaceContainerHighest,
        deleteIconColor: colorScheme.onSurfaceVariant,
        disabledColor: colorScheme.onSurface.withOpacity(0.12),
        selectedColor: colorScheme.secondaryContainer,
        secondarySelectedColor: colorScheme.secondaryContainer,
        padding: const EdgeInsets.symmetric(
          horizontal: AppTokens.space3,
          vertical: AppTokens.space2,
        ),
        labelStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        secondaryLabelStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusMd),
        ),
      ),
    );
  }

  // ============================================
  // TEXT THEME BUILDER
  // ============================================

  static TextTheme _buildTextTheme(ColorScheme colorScheme) {
    return TextTheme(
      displayLarge: AppTokens.displayLarge.copyWith(
        color: colorScheme.onSurface,
      ),
      displayMedium: AppTokens.displayMedium.copyWith(
        color: colorScheme.onSurface,
      ),
      displaySmall: AppTokens.displaySmall.copyWith(
        color: colorScheme.onSurface,
      ),
      headlineLarge: AppTokens.headlineLarge.copyWith(
        color: colorScheme.onSurface,
      ),
      headlineMedium: AppTokens.headlineMedium.copyWith(
        color: colorScheme.onSurface,
      ),
      headlineSmall: AppTokens.headlineSmall.copyWith(
        color: colorScheme.onSurface,
      ),
      titleLarge: AppTokens.titleLarge.copyWith(color: colorScheme.onSurface),
      titleMedium: AppTokens.titleMedium.copyWith(color: colorScheme.onSurface),
      titleSmall: AppTokens.titleSmall.copyWith(
        color: colorScheme.onSurfaceVariant,
      ),
      bodyLarge: AppTokens.bodyLarge.copyWith(color: colorScheme.onSurface),
      bodyMedium: AppTokens.bodyMedium.copyWith(color: colorScheme.onSurface),
      bodySmall: AppTokens.bodySmall.copyWith(
        color: colorScheme.onSurfaceVariant,
      ),
      labelLarge: AppTokens.labelLarge.copyWith(color: colorScheme.onSurface),
      labelMedium: AppTokens.labelMedium.copyWith(
        color: colorScheme.onSurfaceVariant,
      ),
      labelSmall: AppTokens.labelSmall.copyWith(
        color: colorScheme.onSurfaceVariant,
      ),
    );
  }
}
