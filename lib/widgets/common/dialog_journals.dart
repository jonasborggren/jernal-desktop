import 'package:flutter/material.dart';
import 'package:jernal/data/notifiers/journals.dart';
import 'package:jernal/utils/extensions.dart';
import 'package:provider/provider.dart';

class JournalsDialog extends StatefulWidget {
  const JournalsDialog({super.key});

  @override
  State<JournalsDialog> createState() => _JournalsDialogState();
}

class _JournalsDialogState extends State<JournalsDialog> {
  late ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(16),
        child: Consumer<JournalNotifier>(
          builder: (context, journals, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: controller,
                    itemCount: journals.items.length,
                    itemBuilder: (context, index) {
                      final journal = journals.items.reversed.toList()[index];
                      bool current = journals.number - 1 == index;
                      final color = context.colorScheme.onSurface.withOpacity(current ? 1.0 : 0.5);
                      return ListTile(
                        key: GlobalObjectKey(journal),
                        leading: Text(
                          (index + 1).toString(),
                        ),
                        title: Text(
                          journal.title ?? journal.body,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.theme.textTheme.bodyMedium?.copyWith(
                            color: color,
                          ),
                          //style: context.theme.textTheme.bodyMedium,
                        ),
                        subtitle: Text(
                          journal.timestamp.readable(context),
                          style: context.theme.textTheme.labelSmall?.copyWith(
                            color: color,
                          ),
                        ),
                        onTap: () {
                          if (journals.goToJournal(journal)) {
                            Navigator.pop(context);
                          }
                        },
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(context.l10n.close),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    final provider = JournalNotifier.getProvider(context);
    provider.addListener(journalChangedListener);
    onJournalChanged();
  }

  void journalChangedListener() {
    if (mounted) {
      onJournalChanged();
    }
  }

  Future onJournalChanged() async {
    final provider = JournalNotifier.getProvider(context);
    // Add dummy await to schedule this after the first build is complete
    await Future(() {});
    final journal = provider.items[provider.currentIndex];
    final foundKey = GlobalObjectKey(journal).currentContext;
    if (foundKey != null) {
      await Scrollable.ensureVisible(foundKey, alignment: .5);
      print("scroll to: $foundKey");
    } else {
      print("null: $journal");
    }
  }
}
