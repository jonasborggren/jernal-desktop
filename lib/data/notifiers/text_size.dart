import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TextSizeNotifier extends ChangeNotifier {
  final _sizes = [
    9.0,
    11.0,
    13.0,
    16.0,
    18.0,
    22.0,
    26.0,
    32.0,
    40.0,
    64.0,
    80.0,
  ];
  var _sizeIndex = 3;
  var textSize = 16.0;

  static TextSizeNotifier getProvider(BuildContext context) =>
      Provider.of<TextSizeNotifier>(context, listen: false);

  /// Increase
  static void increaseWith(BuildContext context) =>
      getProvider(context).increase();

  void increase() {
    _sizeIndex = min(_sizes.length - 1, _sizeIndex + 1);
    textSize = _sizes[_sizeIndex];
    notifyListeners();
  }

  /// Decrease
  static void decreaseWith(BuildContext context) =>
      getProvider(context).decrease();

  void decrease() {
    _sizeIndex = max(0, _sizeIndex - 1);
    textSize = _sizes[_sizeIndex];
    notifyListeners();
  }

  /// Reset
  static void resetWith(BuildContext context) => getProvider(context).reset();
  void reset() {
    _sizeIndex = 3;
    textSize = _sizes[_sizeIndex];
    notifyListeners();
  }

  String readableSize(BuildContext context) => "$textSize px";
}
