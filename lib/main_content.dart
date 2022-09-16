import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jernal/data/dao/dao_journal.dart';
import 'package:jernal/data/database.dart';
import 'package:jernal/data/dialog_confirm.dart';
import 'package:jernal/data/models/journal.dart';
import 'package:jernal/data/utils/extensions.dart';

class MainContent extends StatefulWidget {
  const MainContent({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  ScrollController? scrollController;
  TextEditingController? textEditingController;

  final FocusNode textFocusNode = FocusNode(canRequestFocus: true);

  List<Journal> items = [];
  var currentIndex = 0;

  JournalDao? journalDao;

  @override
  Widget build(BuildContext context) {
    final titleTheme = Theme.of(context).textTheme.headlineLarge!;
    final canClickNext = currentIndex > 0;
    final canClickPrevious = currentIndex < items.length - 1;
    print(
        "item: $currentIndex / ${items.length}, $canClickPrevious $canClickNext");
    final currentItem = items.isNotEmpty ? items[currentIndex] : null;
    final canClickSave = currentItem?.body != textEditingController?.text;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: const EdgeInsets.only(
          top: 24,
          left: 16,
          right: 16,
          bottom: 16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 48,
              child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 8);
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final opacity = currentIndex == index ? 1.0 : 0.5;
                    final item = items[index];
                    final actualIndex = items.length - index;
                    return Tooltip(
                      key: GlobalObjectKey(index),
                      message: item.timestamp.toIso8601String(),
                      waitDuration: const Duration(seconds: 1),
                      child: InkWell(
                        radius: 16,
                        hoverColor: Colors.transparent,
                        onTap: () {
                          selectItem(index);
                        },
                        child: Text(
                          "#$actualIndex",
                          style: titleTheme.copyWith(
                            color: titleTheme.color!.withOpacity(opacity),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            /*
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: const EdgeInsets.only(
                    left: 4,
                    top: 12,
                    bottom: 12,
                  ),
                ),
                onPressed: canClickNext ? onNextClicked : null,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: const EdgeInsets.only(
                    left: 4,
                    top: 12,
                    bottom: 12,
                  ),
                ),
                onPressed: canClickPrevious ? onPreviousClicked : null,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ),*/
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(50),
                      blurRadius: 4,
                    ),
                  ],
                  border: Border.all(
                    strokeAlign: StrokeAlign.outside,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
                child: TextField(
                  expands: true,
                  focusNode: textFocusNode,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(16),
                    border: InputBorder.none,
                  ),
                  scrollPadding: const EdgeInsets.all(16),
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.top,
                  controller: textEditingController,
                  maxLines: null,
                  minLines: null,
                  style: context.theme.textTheme.bodyMedium,
                  scrollController: scrollController,
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: const EdgeInsets.only(
                      top: 12,
                      bottom: 12,
                    ),
                  ),
                  onPressed: onDeleteClicked,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: Icon(
                      Icons.delete_outline_rounded,
                      size: 20,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: canClickSave ? onSaveClicked : null,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: Text("Save"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void selectItem(int index) {
    setState(() {
      currentIndex = index;
      textEditingController?.text = items[currentIndex].body;
    });
  }

  void onNextClicked() {
    setState(() {
      currentIndex = max(0, currentIndex - 1);
      textEditingController?.text = items[currentIndex].body;
      scrollToIndex();
      print("currentIndex: $currentIndex");
    });
  }

  void onPreviousClicked() {
    setState(() {
      currentIndex = min(items.length - 1, currentIndex + 1);
      textEditingController?.text = items[currentIndex].body;
      scrollToIndex();
      print("currentIndex: $currentIndex");
    });
  }

  void onSaveClicked() {
    final text = textEditingController?.text.toString();
    if (text == null) return; // Something went wrong
    if (text.isEmpty) {
      if (currentIndex != 0) {
        // User wants to remove?
        print("remove existing note");
      } else {
        // New note, but empty
        print("new empty note?");
      }
    } else {
      if (currentIndex == 0) {
        // New note!
        print("save new note");
        journalDao?.insertJournal(Journal.fromBody(text)).then((value) {
          print("Saved!");
          getJournals(true);
        });
      } else {
        final currentItem = items[currentIndex];
        final updatedItem = currentItem.copyWith(body: text);
        print("save existing note: $currentItem to $updatedItem");
        journalDao?.updateJournal(updatedItem).then((value) {
          print("Saved!");
          getJournals(false);
        });
      }
    }
  }

  void onDeleteClicked() {
    showDialog(
        context: context,
        builder: (dialogContext) {
          return ConfirmationDialog(
            dialogContext: dialogContext,
            type: ConfirmationDialogType.deleteJournal,
            onConfirm: () {},
            onCancel: () {},
          );
        });
  }

  void scrollToIndex() {
    Scrollable.ensureVisible(GlobalObjectKey(currentIndex).currentContext!);
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    textEditingController = TextEditingController();

    $FloorAppDatabase.databaseBuilder('app_database.db').build().then((db) {
      journalDao = db.journalDao;
      getJournals(true);
    });

    const MethodChannel("jernal").setMethodCallHandler((call) async {
      print(call);
      Navigator.of(context).pushNamed('/preferences');
      return null;
    });
  }

  @override
  void dispose() {
    scrollController?.dispose();
    textEditingController?.dispose();
    super.dispose();
  }

  Future<void> getJournals(bool setText) async {
    final value = await journalDao!.all();
    setState(() {
      final newItems = [Journal.empty()];
      newItems.addAll(value.reversed);
      if (newItems != items) {
        items = newItems;
        print("found: $items");
        setState(() {});
      }
      if (setText) {
        textEditingController?.text = items[currentIndex].body;
      }
    });
  }
}
