import 'package:flutter/material.dart';
import 'package:jernal/data/dao/dao_journal.dart';
import 'package:jernal/data/dao/database.dart';
import 'package:jernal/data/notifiers/focus_mode.dart';
import 'package:jernal/data/notifiers/journals.dart';
import 'package:jernal/data/notifiers/text_size.dart';
import 'package:jernal/data/preferences.dart';
import 'package:jernal/data/utils/menu_wrapper.dart';
import 'package:jernal/data/utils/theme.dart';
import 'package:jernal/main_content.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dao =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  final prefs = await SharedPreferences.getInstance();
  runApp(JernalApp(
    journalDao: dao.journalDao,
    prefs: prefs,
  ));
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TextSizeNotifier()),
        ChangeNotifierProvider(create: (context) => FocusModeNotifier()),
        ChangeNotifierProvider(
            create: (context) => JournalNotifier.init(journalDao)),
      ],
      child: MaterialApp(
        color: Colors.transparent,
        theme: AppTheme.theme(AppTheme.colorScheme),
        darkTheme: AppTheme.theme(AppTheme.colorSchemeDark),
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          '/': (context) => const MenuWrapper(
                child: MainContent(),
              ),
          '/preferences': (context) => const Preferences(),
        },
      ),
    );
  }
}
