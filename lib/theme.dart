import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final colorScheme = ColorScheme(
    brightness: Brightness.light,
    tertiary: const Color(0xFF17C08F),
    secondary: const Color.fromARGB(255, 0, 0, 0),
    primary: const Color(0xFF193D61),
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    errorContainer: Colors.red,
    onErrorContainer: Colors.white,
    background: const Color.fromARGB(255, 220, 220, 220),
    onBackground: Colors.black,
    surface: Colors.white,
    onSurface: Colors.black,
    surfaceVariant: const Color.fromARGB(255, 247, 248, 250),
    onSurfaceVariant: const Color.fromARGB(255, 145, 155, 178),
    secondaryContainer: const Color.fromARGB(255, 231, 230, 239),
    onSecondaryContainer: Colors.black,
    primaryContainer: Colors.white.withOpacity(0.7),
    onPrimaryContainer: Colors.black,
    inversePrimary: Colors.amber,
    inverseSurface: Colors.black,
  );

  static final colorSchemeDark = ColorScheme(
    brightness: Brightness.dark,
    tertiary: const Color(0xFF17C08F),
    secondary: const Color.fromARGB(255, 0, 0, 0),
    primary: const Color(0xFF193D61),
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onTertiary: Colors.white,
    error: const Color.fromARGB(255, 201, 98, 91),
    onError: Colors.white,
    errorContainer: const Color.fromARGB(255, 201, 98, 91),
    onErrorContainer: Colors.white,
    background: const Color.fromARGB(255, 23, 26, 28),
    onBackground: Colors.white,
    surface: const Color.fromARGB(255, 43, 43, 49),
    onSurface: Colors.white,
    surfaceVariant: const Color.fromARGB(255, 54, 55, 59),
    onSurfaceVariant: Colors.black,
    secondaryContainer: Colors.black.withOpacity(0.1),
    onSecondaryContainer: Colors.white,
    primaryContainer: Colors.black.withOpacity(0.1),
    onPrimaryContainer: Colors.white,
    inversePrimary: Colors.white,
    inverseSurface: Colors.white,
  );

  static ThemeMode themeMode = ThemeMode.system;

  static ListTileThemeData listTileTheme(ColorScheme colorScheme) =>
      ListTileThemeData(
        tileColor: Colors.transparent,
        textColor: colorScheme.onBackground,
        iconColor: colorScheme.onBackground,
        selectedColor: colorScheme.primary,
        selectedTileColor: colorScheme.primary.withOpacity(0.1),
      );

  static TextTheme textTheme(ColorScheme colorScheme) {
    final font = GoogleFonts.rubikTextTheme().copyWith();
    return font.copyWith(
      displayLarge: font.displayLarge?.copyWith(
        color: colorScheme.onBackground,
        fontSize: 42,
      ),
      displayMedium: font.displayMedium?.copyWith(
        color: colorScheme.onBackground,
        fontSize: 28,
      ),
      displaySmall: font.displaySmall?.copyWith(
        color: colorScheme.onBackground,
        fontSize: 21,
      ),
      headlineLarge: font.headlineMedium?.copyWith(
        color: colorScheme.onSurface,
        fontSize: 32,
      ),
      headlineMedium: font.headlineMedium?.copyWith(
        color: colorScheme.onSurface,
        fontSize: 24,
      ),
      headlineSmall: font.headlineSmall?.copyWith(
        color: colorScheme.onSurface,
        fontSize: 20,
      ),
      titleLarge: font.titleLarge?.copyWith(
        color: colorScheme.onSurface,
        fontSize: 13,
      ),
      labelLarge: font.labelLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: colorScheme.onSurface,
      ),
      bodySmall: font.bodySmall?.copyWith(
        color: colorScheme.onSurface,
        fontSize: 14,
      ),
      bodyMedium: font.bodyMedium?.copyWith(
        color: colorScheme.onSurface,
        fontSize: 18,
      ),
      bodyLarge: font.bodyLarge?.copyWith(
        color: colorScheme.onSurface,
        fontSize: 24,
      ),
    );
  }

  static ThemeData theme(ColorScheme colorScheme) => ThemeData(
        primaryColor: colorScheme.primary,
        highlightColor: colorScheme.onBackground.withOpacity(0.15),
        hoverColor: colorScheme.onBackground.withOpacity(0.1),
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(2.0),
            ),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          hoverColor: colorScheme.surface,
          fillColor: colorScheme.surface,
          isDense: true,
        ),
        dividerColor: colorScheme.onSurface.withOpacity(0.1),
        listTileTheme: listTileTheme(colorScheme),
        textTheme: textTheme(colorScheme),
        buttonTheme: const ButtonThemeData(),
        progressIndicatorTheme:
            ProgressIndicatorThemeData(color: colorScheme.primary),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled) ||
                  states.contains(MaterialState.error)) {
                return colorScheme.onSurface.withOpacity(0.5);
              }
              return colorScheme.onPrimary;
            }),
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return colorScheme.onSurface.withOpacity(0.1);
              } else if (states.contains(MaterialState.error)) {
                return colorScheme.error;
              }
              return colorScheme.primary;
            }),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            textStyle: MaterialStateProperty.resolveWith((states) {
              return textTheme(colorScheme).labelLarge?.copyWith(
                    fontStyle: FontStyle.normal,
                    color: states.contains(MaterialState.disabled) &&
                            states.length == 1
                        ? colorScheme.primary
                        : colorScheme.onPrimary,
                  );
            }),
          ),
        ),
        colorScheme: colorScheme.copyWith(
            primary: Colors.grey, background: colorScheme.background),
      );
}
