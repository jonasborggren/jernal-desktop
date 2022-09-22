import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension BuildContextExtensions on BuildContext {
  /// Theme & colors
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;

  /// Localizations
  AppLocalizations get l10n => AppLocalizations.of(this);
}

extension StateExtensions on State<StatefulWidget> {
  /// Localizations
  AppLocalizations get l10n => AppLocalizations.of(context);
}
