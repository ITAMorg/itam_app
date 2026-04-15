import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Backgrounds
  static const background = Color(0xFF222222);
  static const surface = Color(0xFF343434);
  static const border = Color(0xFFB2B2B2);

  // Brand
  static const primary = Color(0xFF1D4ED8);

  // Text
  static const textPrimary = Colors.white;
  static const textSecondary = Color(0xFF8888AA);
}

class AssetStatusColors {
  final Color inService;
  final Color broken;
  final Color maintenance;
  final Color inStock;

  const AssetStatusColors({
    required this.inService,
    required this.broken,
    required this.maintenance,
    required this.inStock,
  });
}

class AssetStatusThemeExtension
    extends ThemeExtension<AssetStatusThemeExtension> {
  final AssetStatusColors statusColors;

  const AssetStatusThemeExtension({required this.statusColors});

  @override
  AssetStatusThemeExtension copyWith({AssetStatusColors? statusColors}) {
    return AssetStatusThemeExtension(
      statusColors: statusColors ?? this.statusColors,
    );
  }

  @override
  AssetStatusThemeExtension lerp(
    ThemeExtension<AssetStatusThemeExtension>? other,
    double t,
  ) {
    return this;
  }
}

class AppTextStyles {
  static TextStyle get titleLarge => GoogleFonts.syne(
    color: AppColors.textPrimary,
    fontSize: 48,
    fontWeight: FontWeight.w700,
  );

  static TextStyle get titleMedium => GoogleFonts.syne(
    color: AppColors.textPrimary,
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

  static TextStyle get buttonLabel => GoogleFonts.syne(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get bodyMedium => GoogleFonts.syne(
    color: AppColors.textPrimary,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get labelMedium => GoogleFonts.syne(
    color: AppColors.textSecondary,
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.2,
  );

  static TextStyle get labelSmall => GoogleFonts.syne(
    color: AppColors.textSecondary,
    fontSize: 8,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );
}

class AppTheme {
  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,
    textTheme: GoogleFonts.syneTextTheme(
      const TextTheme(
        displayLarge: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 48,
          fontWeight: FontWeight.w700,
        ),
        titleMedium: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        bodyMedium: TextStyle(color: AppColors.textPrimary, fontSize: 14),
        labelSmall: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
        ),
      ),
    ),

    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      surface: AppColors.surface,
      onPrimary: Colors.white,
      onSurface: AppColors.textPrimary,
    ),

    // InputDecoration
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      prefixIconColor: AppColors.textSecondary,
      suffixIconColor: AppColors.textSecondary,
    ),

    // ElevatedButton
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 0,
        textStyle: GoogleFonts.syne(fontSize: 20, fontWeight: FontWeight.w600),
      ),
    ),

    // TextButton
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        textStyle: GoogleFonts.syne(fontSize: 13),
      ),
    ),

    extensions: const [
      AssetStatusThemeExtension(
        statusColors: AssetStatusColors(
          inService: Color(0xFF2E7D32),
          broken: Color(0xFFCF2A2D),
          maintenance: Colors.orange,
          inStock: Color(0xFFE1E1E1),
        ),
      ),
    ],
  );
}
