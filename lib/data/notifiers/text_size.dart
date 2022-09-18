import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _defaultFontScale = 1.0;
const _defaultIndex = 3;

class TextSizeNotifier extends ChangeNotifier {
  final _sizes = [
    _defaultFontScale * 0.5,
    _defaultFontScale * 0.66,
    _defaultFontScale * 0.75,
    _defaultFontScale,
    _defaultFontScale * 1.25,
    _defaultFontScale * 1.5,
    _defaultFontScale * 2.0,
    _defaultFontScale * 3.0,
    _defaultFontScale * 5.0,
    _defaultFontScale * 10.0,
  ];
  var _sizeIndex = _defaultIndex;
  var textSizeMultiplier = _defaultFontScale;

  static TextSizeNotifier getProvider(BuildContext context) =>
      Provider.of<TextSizeNotifier>(context, listen: false);

  /// Increase
  static void increaseWith(BuildContext context) =>
      getProvider(context).increase();
  void increase() {
    _sizeIndex = min(_sizes.length - 1, _sizeIndex + 1);
    textSizeMultiplier = _sizes[_sizeIndex];
    notifyListeners();
  }

  /// Decrease
  static void decreaseWith(BuildContext context) =>
      getProvider(context).decrease();
  void decrease() {
    _sizeIndex = max(0, _sizeIndex - 1);
    textSizeMultiplier = _sizes[_sizeIndex];
    notifyListeners();
  }

  /// Reset
  static void resetWith(BuildContext context) => getProvider(context).reset();
  void reset() {
    _sizeIndex = _defaultIndex;
    textSizeMultiplier = _sizes[_defaultIndex];
    notifyListeners();
  }
}
