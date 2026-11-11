import 'package:flutter/material.dart';

ThemeData traktoTheme(Brightness brightness) {
  final dark = brightness == Brightness.dark;
  final colors =
      ColorScheme.fromSeed(
        seedColor: const Color(0xFF007BDF),
        brightness: brightness,
      ).copyWith(
        primary: const Color(0xFF0073CE),
        onPrimary: Colors.white,
        secondary: const Color(0xFF00265F),
        onSecondary: Colors.white,
        primaryContainer: Color(dark ? 0xFF142F49 : 0xFFE8F3FF),
        onPrimaryContainer: Color(dark ? 0xFF70BFFF : 0xFF0069BD),
        surface: Color(dark ? 0xFF1A2635 : 0xFFFFFFFF),
        surfaceContainerHighest: Color(dark ? 0xFF202F41 : 0xFFFAFAFA),
        onSurface: Color(dark ? 0xFFE7EFFA : 0xFF00265F),
        onSurfaceVariant: Color(dark ? 0xFFB4C1D2 : 0xFF5B6472),
        outline: Color(dark ? 0xFF7489A5 : 0xFF8191A7),
        outlineVariant: Color(dark ? 0xFF3A4B61 : 0xFFDCE2E8),
        error: Color(dark ? 0xFFFFA39B : 0xFFB3261E),
        onError: Color(dark ? 0xFF101925 : 0xFFFFFFFF),
        errorContainer: Color(dark ? 0xFF3C242B : 0xFFFDEEEE),
      );
  final background = Color(dark ? 0xFF101925 : 0xFFFAFAFA);
  return ThemeData(
    colorScheme: colors,
    scaffoldBackgroundColor: background,
    appBarTheme: AppBarTheme(
      backgroundColor: background,
      foregroundColor: colors.onSurface,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(fontSize: 22, color: colors.onSurface),
      toolbarHeight: 64,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: colors.surfaceContainerHighest,
      indicatorColor: colors.primaryContainer,
      iconTheme: WidgetStateProperty.resolveWith(
        (states) => IconThemeData(
          color: states.contains(WidgetState.selected)
              ? colors.onPrimaryContainer
              : colors.onSurfaceVariant,
        ),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
  );
}
