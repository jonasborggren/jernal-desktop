import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jernal/l10n/app_localizations.dart';

extension BuildContextExtensions on BuildContext {
  /// Theme & colors
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;

  /// Localizations
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

extension StateExtensions on State<StatefulWidget> {
  /// Localizations
  AppLocalizations get l10n => AppLocalizations.of(context)!;
}

extension ThemeModeExtensions on ThemeMode {
  String readable(BuildContext context) {
    switch (this) {
      case ThemeMode.system:
        return context.l10n.preferencesThemeAuto;
      case ThemeMode.light:
        return context.l10n.preferencesThemeLight;
      case ThemeMode.dark:
        return context.l10n.preferencesThemeDark;
    }
  }
}

extension DateTimeExtensions on DateTime {
  String readable(BuildContext context) {
    final now = DateTime.now();
    final monthReadable = DateFormat.MMMEd().format(this);
    final time = TimeOfDay.fromDateTime(this).format(context);
    if (now.year - year > 1) return DateFormat.yMMMEd().format(this);
    if (now.month == month && now.day != day) {
      return "$monthReadable $time";
    }
    return DateFormat().format(this);
  }
}
