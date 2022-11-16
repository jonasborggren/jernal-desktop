import 'package:flutter/material.dart';
import 'package:jernal/utils/extensions.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FocusModeNotifier extends ChangeNotifier {
  FocusModeNotifier(this.sharedPreferences);

  final SharedPreferences sharedPreferences;
  bool get isFocusModeEnabled =>
      sharedPreferences.getBool("focus_mode_enabled") ?? false;

  static FocusModeNotifier init(SharedPreferences prefs) {
    return FocusModeNotifier(prefs);
  }

  static FocusModeNotifier getProvider(BuildContext context) =>
      Provider.of<FocusModeNotifier>(context, listen: false);

  static void toggleWith(BuildContext context) => getProvider(context).toggle();

  void toggle() {
    setFocusMode(!isFocusModeEnabled);
  }

  static void setFocusModeWith(BuildContext context, bool enabled) =>
      getProvider(context).setFocusMode(enabled);

  Future setFocusMode(bool enabled) async {
    await sharedPreferences.setBool("focus_mode_enabled", enabled);
    notifyListeners();
  }

  String readable(BuildContext context) => isFocusModeEnabled
      ? context.l10n.messagesFocusModeEnabled
      : context.l10n.messagesFocusModeDisabled;
}
