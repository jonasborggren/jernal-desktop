import 'package:flutter/material.dart';
import 'package:jernal/data/notifiers/onboarding.dart';
import 'package:jernal/data/notifiers/text_size.dart';
import 'package:jernal/data/notifiers/theme_mode.dart';
import 'package:jernal/utils/extensions.dart';
import 'package:jernal/widgets/common/dialog_confirm.dart';
import 'package:jernal/widgets/common/page_wrapper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences extends StatefulWidget {
  const Preferences({super.key});

  @override
  State<Preferences> createState() => _PreferencesState();
}

class _PreferencesState extends State<Preferences> {
  SharedPreferences? sharedPreferences;

  @override
  Widget build(BuildContext context) {
    final sharedPreferences = this.sharedPreferences;
    final titleStyle = context.theme.textTheme.labelLarge!.copyWith(
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
              hoverColor: Colors.transparent,
              radius: 40,
              child: const Icon(Icons.arrow_back_ios),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          sharedPreferences == null
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      ListTile(
                        title: Row(
                          children: [
                            Text(
                              l10n.preferencesDonate,
                              style: titleStyle,
                            ),
                            const ComingSoon()
                          ],
                        ),
                        subtitle: Text(l10n.preferencesDonateDescription),
                        dense: true,
                        onTap: () {},
                        trailing: const Icon(Icons.flood_rounded),
                      ),
                      ListTile(
                        title: Row(
                          children: [
                            Text(
                              l10n.preferencesProUnlock,
                              style: titleStyle,
                            ),
                            const ComingSoon(),
                          ],
                        ),
                        subtitle: Text(l10n.preferencesProUnlockDescription),
                        dense: true,
                        onTap: () {},
                        trailing: const Icon(Icons.open_in_browser_rounded),
                      ),
                      ListTile(
                        title: Text(
                          l10n.preferencesOnboardingReset,
                          style: titleStyle,
                        ),
                        subtitle:
                            Text(l10n.preferencesOnboardingResetDescription),
                        dense: true,
                        onTap: () {
                          OnboardingNotifier.resetWith(context).then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    l10n.preferencesOnboardingResetSuccess),
                              ),
                            );
                          });
                        },
                        trailing: const Icon(Icons.help_outline_rounded),
                      ),
                      const Divider(),
                      Consumer<ThemeModeNotifier>(
                        builder: (context, themeMode, _) {
                          return ListTile(
                            title: Text(
                              l10n.preferencesTheme,
                              style: titleStyle,
                            ),
                            dense: true,
                            onTap: () {
                              themeMode.next();
                            },
                            trailing: Text(themeMode.mode.readable(context)),
                          );
                        },
                      ),
                      ListTile(
                        title: Row(
                          children: [
                            Text(
                              l10n.preferencesTextAnimations,
                              style: titleStyle,
                            ),
                            const Experimental()
                          ],
                        ),
                        subtitle:
                            Text(l10n.preferencesTextAnimationsDescription),
                        dense: true,
                        onTap: () async {
                          final value = sharedPreferences
                              .getBool("prefs_animations_text");
                          String message;
                          if (value == null || value == true) {
                            sharedPreferences.setBool(
                                "prefs_animations_text", false);
                            message =
                                l10n.preferencesTextAnimationsSuccessDisabled;
                          } else {
                            sharedPreferences.setBool(
                                "prefs_animations_text", true);
                            message =
                                l10n.preferencesTextAnimationsSuccessEnabled;
                          }
                          setState(() {});
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(message),
                            ),
                          );
                        },
                        trailing: Icon(
                          sharedPreferences.getBool("prefs_animations_text") ==
                                  false
                              ? Icons.play_disabled_rounded
                              : Icons.play_arrow_rounded,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          l10n.preferencesTextSizeReset,
                          style: titleStyle,
                        ),
                        subtitle:
                            Text(l10n.preferencesTextSizeResetDescription),
                        dense: true,
                        onTap: () {
                          TextSizeNotifier.resetWith(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text(l10n.preferencesTextSizeResetSuccess),
                            ),
                          );
                        },
                        trailing: const Icon(Icons.text_fields_rounded),
                      ),
                      const Divider(),
                      ListTile(
                        title: Row(
                          children: [
                            Text(
                              l10n.preferencesExportJournals,
                              style: titleStyle,
                            ),
                            const ComingSoon(),
                          ],
                        ),
                        subtitle:
                            Text(l10n.preferencesExportJournalsDescription),
                        dense: true,
                        onTap: () {},
                        trailing: const Icon(Icons.file_download_outlined),
                      ),
                      ListTile(
                        title: Row(
                          children: [
                            Text(
                              l10n.preferencesDeleteAllJournals,
                              style: titleStyle.copyWith(
                                color: context.colorScheme.error,
                              ),
                            ),
                            const ComingSoon(),
                          ],
                        ),
                        subtitle: Text(
                          l10n.preferencesDeleteAllJournalsDescription,
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
                                  type:
                                      ConfirmationDialogType.deleteAllJournals,
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

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      setState(() {
        sharedPreferences = value;
      });
    });
  }
}

class ComingSoon extends StatelessWidget {
  const ComingSoon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.onSurface,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      margin: const EdgeInsets.only(left: 8),
      child: Text(
        context.l10n.comingSoon.toUpperCase(),
        style: TextStyle(
          color: context.colorScheme.surface,
          fontSize: 10,
        ),
      ),
    );
  }
}

class Experimental extends StatelessWidget {
  const Experimental({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.tertiary,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      margin: const EdgeInsets.only(left: 8),
      child: Text(
        context.l10n.experimental.toUpperCase(),
        style: TextStyle(
          color: context.colorScheme.onTertiary,
          fontSize: 10,
        ),
      ),
    );
  }
}
