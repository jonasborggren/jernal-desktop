import 'package:flutter/material.dart';

enum ConfirmationDialogType {
  deleteJournal,
}

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    required this.type,
    required this.dialogContext,
    required this.onConfirm,
    required this.onCancel,
  });

  final BuildContext dialogContext;
  final ConfirmationDialogType type;
  final Function onConfirm;
  final Function onCancel;

  @override
  Widget build(BuildContext context) {
    var text = "Are you sure?";
    switch (type) {
      case ConfirmationDialogType.deleteJournal:
        text = "Are you sure you want to remove this journal?";
        break;
    }
    return Dialog(
        child: Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Text(text),
    ));
  }
}
