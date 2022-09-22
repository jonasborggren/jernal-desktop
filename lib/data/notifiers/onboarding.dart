import 'package:flutter/material.dart';
import 'package:jernal/data/notifiers/focus_mode.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingNotifier extends ChangeNotifier {
  bool isDoingOnboarding = false;

  int step = 0;

  void nextStep() {
    step++;
    notifyListeners();
  }

  static OnboardingNotifier init(BuildContext context) {
    OnboardingNotifier instance = OnboardingNotifier();
    SharedPreferences.getInstance().then((prefs) {
      final onboardingDone = prefs.getBool("onboarding_done");
      if (onboardingDone == false || onboardingDone == null) {
        Future.delayed(const Duration(seconds: 2)).then((_) {
          instance.isDoingOnboarding = true;
          FocusModeNotifier.setFocusModeWith(context, false);
          instance.notifyListeners();
        });
      }
    });
    return instance;
  }

  void complete() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool("onboarding_done", true);
      isDoingOnboarding = false;
      notifyListeners();
    });
  }

  static Future resetWith(BuildContext context) {
    return Provider.of<OnboardingNotifier>(context, listen: false).reset();
  }

  Future reset() {
    return SharedPreferences.getInstance().then((prefs) {
      prefs.setBool("onboarding_done", false);
      notifyListeners();
    });
  }
}
