import 'package:flutter/material.dart';
import 'package:jernal/data/dao/dao_journal.dart';
import 'package:jernal/data/notifiers/focus_mode.dart';
import 'package:jernal/data/notifiers/game.dart';
import 'package:jernal/data/notifiers/journals.dart';
import 'package:jernal/data/notifiers/onboarding.dart';
import 'package:jernal/data/notifiers/text_size.dart';
import 'package:provider/provider.dart';

class MainProvider extends StatelessWidget {
  const MainProvider({
    super.key,
    required this.child,
    required this.journalDao,
  });

  final Widget child;
  final JournalDao journalDao;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TextSizeNotifier()),
        ChangeNotifierProvider(create: (_) => FocusModeNotifier()),
        ChangeNotifierProvider(create: (_) => GameNotifier()),
        ChangeNotifierProvider(create: (_) => JournalNotifier.init(journalDao)),
        ChangeNotifierProvider(
          create: (context) => OnboardingNotifier.init(context),
        ),
      ],
      child: child,
    );
  }
}
