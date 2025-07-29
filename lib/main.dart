import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jernal/data/dao/dao_journal.dart';
import 'package:jernal/data/dao/database.dart';
import 'package:jernal/data/notifiers/text_size.dart';
import 'package:jernal/data/notifiers/theme_mode.dart';
import 'package:jernal/l10n/app_localizations.dart';
import 'package:jernal/main_provider.dart';
import 'package:jernal/menu_wrapper.dart';
import 'package:jernal/theme.dart';
import 'package:jernal/utils/method_channel.dart';
import 'package:jernal/widgets/main/main_content.dart';
import 'package:jernal/widgets/preferences/preferences.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final daos = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    JernalApp(
      journalDao: daos.journalDao,
      prefs: prefs,
    ),
  );
}

class JernalApp extends StatelessWidget {
  const JernalApp({
    super.key,
    required this.journalDao,
    required this.prefs,
  });

  final JournalDao journalDao;
  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return MainProvider(
      sharedPreferences: prefs,
      journalDao: journalDao,
      child: Consumer2<ThemeModeNotifier, TextSizeNotifier>(
        builder: (context, notifier, textSize, _) {
          methodChannelHandler.setThemeMode(notifier.mode);
          // TextScaler textScaler = const TextScaler.linear(textSize.scale);
          // MediaQuery(
          //  data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(textSize.scale)),
          //  child: MainContent(),
          // ),

          return MaterialApp(
            color: Colors.transparent,
            theme: AppTheme.theme(AppTheme.colorScheme),
            darkTheme: AppTheme.theme(AppTheme.colorSchemeDark),
            themeMode: notifier.mode,
            debugShowCheckedModeBanner: false,
            initialRoute: "/",
            routes: {
              '/': (context) => const MenuWrapper(child: MainContent()),
              '/preferences': (context) => const Preferences(),
            },
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''),
            ],
          );
        },
      ),
    );
  }
}
