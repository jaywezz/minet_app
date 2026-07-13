import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // Font sizes
  static const double displayLarge = 32.0;
  static const double displayMedium = 28.0;
  static const double displaySmall = 24.0;
  
  static const double headlineLarge = 22.0;
  static const double headlineMedium = 20.0;
  static const double headlineSmall = 18.0;
  
  static const double titleLarge = 16.0;
  static const double titleMedium = 14.0;
  static const double titleSmall = 12.0;
  
  static const double bodyLarge = 16.0;
  static const double bodyMedium = 14.0;
  static const double bodySmall = 12.0;
  
  static const double labelLarge = 14.0;
  static const double labelMedium = 12.0;
  static const double labelSmall = 10.0;

  static ThemeData get light => _themeData(Brightness.light);
  static ThemeData get dark => _themeData(Brightness.dark);

  static ThemeData _themeData(Brightness brightness) {
    // Customized ThemeData for Washamba
    const washambaColorScheme = FlexSchemeColor(
      primary: Color(0xFF2D7238), // Dark Green for primary color
      primaryContainer: Color(0xFFF37446), // Light Green
      secondary: Color(0xFFFFA726), // Orange for accents
      secondaryContainer: Color(0xFFFFD270), // Lighter orange for secondary containers


      tertiary: Color(0xFF77BB43), // Purple for tertiary elements
      tertiaryContainer: Color(0xFFC8DBF8), // Light blue for tertiary containers
    );

    final lightTheme = FlexThemeData.light(
      colors: washambaColorScheme,
      surfaceMode: FlexSurfaceMode.highSurfaceLowScaffold,
      blendLevel: 3,
      appBarStyle: FlexAppBarStyle.background,
      bottomAppBarElevation: 2.0,
      subThemesData: const FlexSubThemesData(
        useM2StyleDividerInM3: true,
        blendOnLevel: 6,
        blendOnColors: false,
        useTextTheme: true,
        adaptiveRadius: FlexAdaptive.excludeWebAndroidFuchsia(),
        defaultRadiusAdaptive: 12.0,
        elevatedButtonSchemeColor: SchemeColor.primary,
        elevatedButtonSecondarySchemeColor: SchemeColor.primary,
        outlinedButtonOutlineSchemeColor: SchemeColor.primary,
        toggleButtonsBorderSchemeColor: SchemeColor.primary,
        segmentedButtonSchemeColor: SchemeColor.primary,
        inputDecoratorFillColor: Color(0xFFFFFFFF),
        inputDecoratorSchemeColor: SchemeColor.onPrimary, // Inputs use primary color
        inputDecoratorBorderSchemeColor: SchemeColor.outline,
        inputDecoratorBorderWidth: 0.5, // Thin border width for inputs
        inputDecoratorRadius: 12, // Rounded inputs
        inputDecoratorBorderType: FlexInputBorderType.outline,
        inputSelectionHandleSchemeColor: SchemeColor.primaryContainer, // Handle color
        inputCursorSchemeColor: SchemeColor.primary, // Cursor color
        alignedDropdown: true,
        fabUseShape: true,
        fabAlwaysCircular: true,
        fabSchemeColor: SchemeColor.secondary,
        cardRadius: 12.0,
        bottomSheetRadius: 18.0,
        bottomSheetElevation: 4.0,
        navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
        navigationBarSelectedIconSchemeColor: SchemeColor.onPrimary,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: displayLarge, fontWeight: FontWeight.bold),
        displayMedium: TextStyle(fontSize: displayMedium, fontWeight: FontWeight.bold),
        displaySmall: TextStyle(fontSize: displaySmall, fontWeight: FontWeight.bold),
        
        headlineLarge: TextStyle(fontSize: headlineLarge, fontWeight: FontWeight.w600),
        headlineMedium: TextStyle(fontSize: headlineMedium, fontWeight: FontWeight.w600),
        headlineSmall: TextStyle(fontSize: headlineSmall, fontWeight: FontWeight.w600),
        
        titleLarge: TextStyle(fontSize: titleLarge, fontWeight: FontWeight.w500),
        titleMedium: TextStyle(fontSize: titleMedium, fontWeight: FontWeight.w500),
        titleSmall: TextStyle(fontSize: titleSmall, fontWeight: FontWeight.w500),
        
        bodyLarge: TextStyle(fontSize: bodyLarge),
        bodyMedium: TextStyle(fontSize: bodyMedium),
        bodySmall: TextStyle(fontSize: bodySmall),
        
        labelLarge: TextStyle(fontSize: labelLarge, fontWeight: FontWeight.w500),
        labelMedium: TextStyle(fontSize: labelMedium, fontWeight: FontWeight.w500),
        labelSmall: TextStyle(fontSize: labelSmall, fontWeight: FontWeight.w500),
      ),
      fontFamily: 'Inter',
    );

    return lightTheme;
  }
}
