import 'package:flutter/material.dart';
import 'package:jernal/data/utils/extensions.dart';
import 'package:jernal/data/widgets/dialog_confirm.dart';
import 'package:jernal/data/widgets/page_wrapper.dart';

class Preferences extends StatefulWidget {
  const Preferences({super.key});

  @override
  State<Preferences> createState() => _PreferencesState();
}

class _PreferencesState extends State<Preferences> {
  @override
  Widget build(BuildContext context) {
    final titleStyle = context.theme.textTheme.button!.copyWith(
      fontSize: 16,
    );
    return PageWrapper(
      backgroundColor: context.colorScheme.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            child: InkWell(
              radius: 40,
              child: const Icon(Icons.arrow_back_ios),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 32),
                ListTile(
                  title: Text(
                    "Donate",
                    style: titleStyle,
                  ),
                  subtitle: const Text(
                    "Help me develop this app further!",
                  ),
                  dense: true,
                  onTap: () {},
                  trailing: const Icon(Icons.flood_rounded),
                ),
                ListTile(
                  title: Text(
                    "Unlock PRO features",
                    style: titleStyle,
                  ),
                  subtitle: const Text(
                    "Buy the PRO version of this app to unlock all kinds of cool features",
                  ),
                  dense: true,
                  onTap: () {},
                  trailing: const Icon(Icons.open_in_browser_rounded),
                ),
                const Divider(),
                ListTile(
                  title: Text(
                    "Set default text size",
                    style: titleStyle,
                  ),
                  subtitle: const Text(
                    "Set a more comfortable text size",
                  ),
                  dense: true,
                  onTap: () {},
                  trailing: const Icon(Icons.text_fields_rounded),
                ),
                const Divider(),
                ListTile(
                  title: Text(
                    "Export journals",
                    style: titleStyle,
                  ),
                  subtitle: const Text(
                    "Export all your journals into text files to store for later",
                  ),
                  dense: true,
                  onTap: () {},
                  trailing: const Icon(Icons.file_download_outlined),
                ),
                ListTile(
                  title: Text(
                    "Delete all journals",
                    style: titleStyle.copyWith(
                      color: context.colorScheme.error,
                    ),
                  ),
                  subtitle: Text(
                    "Delete all your journals. Be careful, this cannot be undone!",
                    style: TextStyle(
                      color: context.colorScheme.error,
                    ),
                  ),
                  dense: true,
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return ConfirmationDialog(
                            type: ConfirmationDialogType.deleteAllJournals,
                            dialogContext: context,
                            onConfirm: () {},
                            onCancel: () {},
                            onThirdAction: () {},
                          );
                        });
                  },
                  trailing: Icon(
                    Icons.delete_forever_rounded,
                    color: context.colorScheme.error,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
