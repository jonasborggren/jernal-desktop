import 'package:flutter/material.dart';
import 'package:jernal/data/preferences.dart';
import 'package:jernal/data/utils/theme.dart';
import 'package:jernal/main_content.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const JernalApp());
}

class JernalApp extends StatelessWidget {
  const JernalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.transparent,
      theme: AppTheme.theme(AppTheme.colorScheme),
      darkTheme: AppTheme.theme(AppTheme.colorSchemeDark),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        '/': (context) => const MainContent(),
        '/preferences': (context) => const Preferences(),
      },
    );
  }
}
