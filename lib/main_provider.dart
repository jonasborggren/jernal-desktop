import 'package:flutter/material.dart';
import 'package:jernal/data/dao/dao_journal.dart';
import 'package:jernal/data/notifiers/focus_mode.dart';
import 'package:jernal/data/notifiers/game.dart';
import 'package:jernal/data/notifiers/journals.dart';
import 'package:jernal/data/notifiers/messenger.dart';
import 'package:jernal/data/notifiers/onboarding.dart';
import 'package:jernal/data/notifiers/text_size.dart';
import 'package:jernal/data/notifiers/theme_mode.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainProvider extends StatelessWidget {
  const MainProvider({
    super.key,
    required this.child,
    required this.journalDao,
    required this.sharedPreferences,
  });

  final Widget child;
  final JournalDao journalDao;
  final SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TextSizeNotifier()),
        ChangeNotifierProvider(create: (_) => GameNotifier()),
        ChangeNotifierProvider(create: (_) => MessageNotifier()),
        ChangeNotifierProvider(create: (_) => JournalNotifier.init(journalDao)),
        ChangeNotifierProvider(
            create: (_) => FocusModeNotifier.init(sharedPreferences)),
        ChangeNotifierProvider(
            create: (_) => ThemeModeNotifier.init(sharedPreferences)),
        ChangeNotifierProvider(
          create: (context) => OnboardingNotifier.init(context),
        ),
      ],
      child: child,
    );
  }
}
