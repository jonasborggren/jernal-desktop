import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:jernal/utils/extensions.dart';
import 'package:jernal/utils/method_channel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModeNotifier extends ChangeNotifier {
  ThemeModeNotifier(this.preferences);

  final SharedPreferences preferences;
  var mode = ThemeMode.system;

  static ThemeModeNotifier getProvider(BuildContext context) =>
      Provider.of<ThemeModeNotifier>(context, listen: false);

  static void nextWith(BuildContext context) {
    getProvider(context).next();
  }

  void next() {
    ThemeMode? mode;
    switch (this.mode) {
      case ThemeMode.light:
        mode = ThemeMode.dark;
        break;
      case ThemeMode.dark:
        mode = ThemeMode.system;
        break;
      case ThemeMode.system:
        mode = ThemeMode.light;
        break;
    }
    setThemeMode(mode);
  }

  void setThemeMode(ThemeMode mode) {
    preferences.setString("theme_mode", mode.name);
    this.mode = mode;
    notifyListeners();
    methodChannelHandler.setThemeMode(mode);
  }

  static ThemeModeNotifier init(SharedPreferences prefs) {
    ThemeModeNotifier notifier = ThemeModeNotifier(prefs);
    notifier.mode = ThemeMode.values.firstWhereOrNull(
            (element) => element.name == prefs.getString("theme_mode")) ??
        ThemeMode.system;
    return notifier;
  }

  String readable(BuildContext context) {
    switch (mode) {
      case ThemeMode.system:
        return context.l10n.preferencesThemeAuto;
      case ThemeMode.light:
        return context.l10n.preferencesThemeLight;
      case ThemeMode.dark:
        return context.l10n.preferencesThemeDark;
    }
  }
}
