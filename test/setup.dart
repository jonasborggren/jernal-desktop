import 'package:flutter/material.dart';
import 'package:jernal/data/dao/dao_journal.dart';
import 'package:jernal/data/models/journal.dart';
import 'package:jernal/main_provider.dart';

Widget buildTestScaffold({
  required Widget child,
  JournalDaoMock? journalDao,
}) {
  return MainProvider(
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
