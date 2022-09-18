import 'package:flutter/material.dart';
import 'package:jernal/data/utils/extensions.dart';

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
    required this.onCancel,
    this.onThirdAction,
  });

  final BuildContext dialogContext;
  final ConfirmationDialogType type;
  final Function() onConfirm;
  final Function() onCancel;
  final Function()? onThirdAction;

  @override
  Widget build(BuildContext context) {
    String text = "Are you sure?";
    String confirmText = "OK";
    String? thirdText;
    Color? confirmColor;
    switch (type) {
      case ConfirmationDialogType.deleteJournal:
        text = "Are you sure you want to remove this journal?";
        confirmText = "DELETE";
        confirmColor = context.colorScheme.error;
        break;
      case ConfirmationDialogType.deleteAllJournals:
        text =
            "Are you sure you want to remove all journals? This cannot be undone";
        confirmText = "DELETE ALL";
        thirdText = "EXPORT JOURNALS";
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
                    onCancel();
                  },
                  child: const Text("CANCEL"),
                ),
                if (onThirdAction != null && thirdText != null) ...{
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      onThirdAction!();
                    },
                    child: Text(thirdText),
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
                  child: Text(confirmText),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
