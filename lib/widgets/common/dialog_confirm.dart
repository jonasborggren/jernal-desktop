import 'package:flutter/material.dart';
import 'package:jernal/utils/extensions.dart';

enum ConfirmationDialogType {
  deleteJournal,
  deleteAllJournals,
}

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    required this.type,
    required this.dialogContext,
    required this.onConfirm,
    this.onCancel,
    this.onThirdAction,
  });

  final BuildContext dialogContext;
  final ConfirmationDialogType type;
  final Function() onConfirm;
  final Function()? onCancel;
  final Function()? onThirdAction;

  @override
  Widget build(BuildContext context) {
    String text = context.l10n.areYouSure;
    String confirmText = context.l10n.ok;
    String? thirdText;
    Color? confirmColor;
    switch (type) {
      case ConfirmationDialogType.deleteJournal:
        text = context.l10n.deleteJournalSingle;
        confirmText = context.l10n.delete;
        confirmColor = context.colorScheme.error;
        break;
      case ConfirmationDialogType.deleteAllJournals:
        text = context.l10n.deleteJournalAll;
        confirmText = context.l10n.deleteAll;
        thirdText = context.l10n.preferencesExportJournals;
        confirmColor = context.colorScheme.error;
        break;
    }

    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 300,
              ),
              child: Text(
                text,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    onCancel?.call();
                  },
                  child: Text(context.l10n.cancel.toUpperCase()),
                ),
                if (onThirdAction != null && thirdText != null) ...{
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      onThirdAction!();
                    },
                    child: Text(thirdText.toUpperCase()),
                  ),
                },
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    onConfirm();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: confirmColor,
                  ),
                  child: Text(confirmText.toUpperCase()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
