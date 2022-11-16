import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jernal/data/dao/dao_journal.dart';
import 'package:jernal/data/models/journal.dart';
import 'package:provider/provider.dart';

class JournalNotifier extends ChangeNotifier {
  List<Journal> items = [];
  var currentIndex = 0;

  bool get canGoPrevious => currentIndex < items.length - 1;
  bool get canGoNext => currentIndex > 0;

  int get number => items.length - currentIndex;

  late JournalDao dao;

  static JournalNotifier getProvider(BuildContext context) =>
      Provider.of<JournalNotifier>(context, listen: false);

  static void previousWith(BuildContext context) =>
      getProvider(context).previous();
  void previous() {
    set(currentIndex + 1);
  }

  static void nextWith(BuildContext context) => getProvider(context).next();
  void next() {
    set(currentIndex - 1);
  }

  static void setWith(BuildContext context, int index) =>
      getProvider(context).set(index);

  void set(int index) {
    currentIndex = min(items.length - 1, max(0, index));
    notifyListeners();
  }

  static JournalNotifier init(JournalDao journalDao) {
    JournalNotifier notifier = JournalNotifier();
    notifier.dao = journalDao;
    notifier.getJournals(true);
    return notifier;
  }

  Future getJournals(bool notify) async {
    final value = await dao.all();
    final newItems = [Journal.empty()];
    newItems.addAll(value.reversed);
    if (newItems != items) {
      items = newItems;
    }
    if (notify) {
      notifyListeners();
    }
  }

  static Future deleteWith(BuildContext context) async {
    await getProvider(context).delete();
  }

  Future delete() async {
    final currentItem = items[currentIndex];
    await dao.deleteJournal(currentItem);
    await getJournals(false);
    if (currentIndex >= items.length) {
      currentIndex = items.length - 1;
    }
    notifyListeners();
  }

  static Future updateWith(BuildContext context, String text) async {
    await getProvider(context).update(text);
  }

  Future update(String text) async {
    final currentItem = items[currentIndex];
    final updatedItem = currentItem.copyWith(body: text);
    print("save existing note: $currentItem to $updatedItem");
    await dao.updateJournal(updatedItem);
    notifyListeners();
  }

  static Future insertWith(BuildContext context, String text) async {
    await getProvider(context).insert(text);
  }

  Future save() async {
    final currentItem = items[currentIndex];
    if (currentIndex == 0) {
      await insert(currentItem.body);
    } else {
      await update(currentItem.body);
    }
  }

  Future insert(String text) async {
    await dao.insertJournal(Journal.fromBody(text));
    await getJournals(true);
  }

  bool goToJournal(Journal journal) {
    final index = items.indexOf(journal);
    if (index != -1) {
      currentIndex = index;
      notifyListeners();
      return true;
    }
    return false;
  }
}
