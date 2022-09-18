import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FocusModeNotifier extends ChangeNotifier {
  var isFocusModeEnabled = true;

  static FocusModeNotifier getProvider(BuildContext context) =>
      Provider.of<FocusModeNotifier>(context, listen: false);

  static void toggleWith(BuildContext context) => getProvider(context).toggle();

  void toggle() {
    isFocusModeEnabled = !isFocusModeEnabled;
    notifyListeners();
  }

  static void setFocusModeWith(BuildContext context, bool enabled) =>
      getProvider(context).setFocusMode(enabled);

  void setFocusMode(bool enabled) {
    isFocusModeEnabled = enabled;
    notifyListeners();
  }
}
