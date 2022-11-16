import 'package:flutter/material.dart';
import 'package:jernal/data/dao/dao_journal.dart';
import 'package:jernal/data/models/journal.dart';
import 'package:jernal/main_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget buildTestScaffold({
  required Widget child,
  JournalDaoMock? journalDao,
  SharedPreferences? sharedPreferences,
}) {
  return MainProvider(
    sharedPreferences: sharedPreferences ?? SharedPreferencesMock(),
    journalDao: journalDao ?? JournalDaoMock(),
    child: MaterialApp(
      home: Scaffold(
        body: Center(
          child: child,
        ),
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class JournalDaoMock implements JournalDao {
  List<Journal> mockJournals = [];

  @override
  Future<List<Journal>> all() async => mockJournals;

  @override
  Stream<Journal?> byId(int id) async* {
    final matches = mockJournals.where((element) => element.id == id);
    for (Journal match in matches) {
      yield match;
    }
  }

  @override
  Future<void> deleteJournal(Journal data) async {
    mockJournals.remove(data);
  }

  @override
  Future<void> insertJournal(Journal data) async {
    mockJournals.add(data);
  }

  @override
  Future<void> updateJournal(Journal data) async {
    final index = mockJournals.indexWhere((element) => element.id == data.id);
    if (index == -1) throw Exception("No journal with id ${data.id} found");
    mockJournals[index] = data;
  }
}

class SharedPreferencesMock implements SharedPreferences {
  final Map<String, dynamic> map = {};

  @override
  String getString(String key) => map[key];

  @override
  bool getBool(String key) => map[key];

  @override
  int getInt(String key) => map[key];

  @override
  Future<bool> clear() async {
    map.clear();
    return true;
  }

  @override
  Future<bool> commit() async => true;

  @override
  bool containsKey(String key) => map.containsKey(key);

  @override
  Object? get(String key) => map[key];

  @override
  double? getDouble(String key) => map[key];

  @override
  Set<String> getKeys() => map.keys.toSet();

  @override
  List<String>? getStringList(String key) => map[key];

  @override
  Future<void> reload() async => {};

  @override
  Future<bool> remove(String key) async => map.remove(key);

  @override
  Future<bool> setBool(String key, bool value) async {
    map[key] = value;
    return true;
  }

  @override
  Future<bool> setDouble(String key, double value) async {
    map[key] = value;
    return true;
  }

  @override
  Future<bool> setInt(String key, int value) async {
    map[key] = value;
    return true;
  }

  @override
  Future<bool> setString(String key, String value) async {
    map[key] = value;
    return true;
  }

  @override
  Future<bool> setStringList(String key, List<String> value) async {
    map[key] = value;
    return true;
  }
}
