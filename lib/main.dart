import 'package:flutter/material.dart';
import 'package:jernal/main_content.dart';
import 'package:jernal/theme.dart';

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
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          padding: const EdgeInsets.all(32),
          child: const MainContent(),
        ),
      ),
    );
  }
}
