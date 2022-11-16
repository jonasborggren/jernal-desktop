import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final methodChannelHandler = MethodChannelHandler();

class MethodChannelHandler {
  MethodChannel channel = const MethodChannel("jernal");

  Future setThemeMode(ThemeMode mode) async {
    await channel.invokeMethod("theme_mode", {"mode": mode.name});
  }
}
