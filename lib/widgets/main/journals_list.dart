import 'package:flutter/material.dart';
import 'package:jernal/data/notifiers/journals.dart';
import 'package:provider/provider.dart';

class JournalsSelectableList extends StatelessWidget {
  const JournalsSelectableList({super.key});

  @override
  Widget build(BuildContext context) {
    final titleTheme = Theme.of(context).textTheme.headlineLarge!;

    return SizedBox(
      height: 48,
      child: Consumer<JournalNotifier>(
        builder: (context, notifier, _) {
          final items = notifier.items;
          final currentIndex = notifier.currentIndex;
          return ListView.separated(
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
                    JournalNotifier.setWith(context, index);
                  },
                  child: Text(
                    "#$actualIndex",
                    style: titleTheme.copyWith(
                      color: titleTheme.color!.withOpacity(opacity),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
