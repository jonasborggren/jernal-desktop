import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jernal/extensions.dart';

class MainContent extends StatefulWidget {
  const MainContent({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  ScrollController? scrollController;
  TextEditingController? textEditingController;

  List<String> items = [
    "Hellooooo",
    "What+",
    "Nooo",
    "This is impossible",
    "Not a chance",
    "Hellooooo",
    "What+",
    "Nooo",
    "This is impossible",
    "Not a chance"
  ].reversed.toList();
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final titleTheme = Theme.of(context).textTheme.headlineLarge!;
    final canClickNext = currentIndex > 0;
    final canClickPrevious = currentIndex < items.length - 1;
    print(
        "item: $currentIndex / ${items.length}, $canClickPrevious $canClickNext");
    final currentItem = items[currentIndex];
    final canClickSave = currentItem != textEditingController?.text;
    return MouseRegion(
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
                    message: "3rd July 2022 at 22.30",
                    waitDuration: const Duration(seconds: 1),
                    child: Text(
                      "#$actualIndex",
                      semanticsLabel: "hello?",
                      style: titleTheme.copyWith(
                        color: titleTheme.color!.withOpacity(opacity),
                      ),
                    ),
                  );
                }),
          ),
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
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              width: double.infinity,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: context.colorScheme.onBackground.withAlpha(50),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: TextField(
                expands: true,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(16),
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
                  //items[currentIndex] = value;
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
                    Icons.delete_rounded,
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
    );
  }

  void onNextClicked() {
    setState(() {
      currentIndex = max(0, currentIndex - 1);
      textEditingController?.text = items[currentIndex];
      scrollToIndex();
      print("currentIndex: $currentIndex");
    });
  }

  void onPreviousClicked() {
    setState(() {
      currentIndex = min(items.length - 1, currentIndex + 1);
      textEditingController?.text = items[currentIndex];
      scrollToIndex();
      print("currentIndex: $currentIndex");
    });
  }

  void onSaveClicked() {}

  void onDeleteClicked() {}

  void scrollToIndex() {
    Scrollable.ensureVisible(GlobalObjectKey(currentIndex).currentContext!);
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    scrollController?.dispose();
    textEditingController?.dispose();
    super.dispose();
  }
}
