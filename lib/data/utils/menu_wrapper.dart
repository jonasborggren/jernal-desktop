import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jernal/data/notifiers/focus_mode.dart';
import 'package:jernal/data/notifiers/journals.dart';
import 'package:jernal/data/notifiers/text_size.dart';
import 'package:jernal/data/routes/routes_main.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

enum MenuSelection {
  preferences,
  toggleFocusMode,
  textSizeIncrease,
  textSizeDecrease,
  textSizeReset,
}

class MenuWrapper extends StatelessWidget {
  const MenuWrapper({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Consumer<JournalNotifier>(
      builder: (context, journals, _) {
        return PlatformMenuBar(
          menus: <MenuItem>[
            PlatformMenu(
              label: 'Jernal',
              menus: <MenuItem>[
                PlatformMenuItemGroup(
                  members: <MenuItem>[
                    PlatformMenuItem(
                      label: 'About',
                      onSelected: () {
                        PackageInfo.fromPlatform().then((packageInfo) {
                          String appName = packageInfo.appName;
                          String version = packageInfo.version;
                          String buildNumber = packageInfo.buildNumber;
                          showAboutDialog(
                            context: context,
                            applicationName: appName,
                            applicationVersion:
                                "$version - Build: $buildNumber",
                            applicationIcon: const Icon(Icons.reddit),
                          );
                        });
                      },
                    ),
                    PlatformMenuItem(
                      label: 'Save Journal',
                      shortcut: const SingleActivator(
                        LogicalKeyboardKey.keyS,
                        meta: true,
                      ),
                      onSelected: () {
                        Provider.of<JournalNotifier>(context, listen: false)
                            .save();
                      },
                    ),
                    PlatformMenuItem(
                      label: 'Toggle focus mode',
                      shortcut: const SingleActivator(
                        LogicalKeyboardKey.keyF,
                        meta: true,
                        shift: true,
                      ),
                      onSelected: () {
                        Provider.of<FocusModeNotifier>(context, listen: false)
                            .toggle();
                      },
                    ),
                  ],
                ),
                PlatformMenuItemGroup(
                  members: <MenuItem>[
                    PlatformMenuItem(
                      label: 'Increase text size',
                      shortcut: const SingleActivator(
                        LogicalKeyboardKey.add,
                        meta: true,
                      ),
                      onSelected: () {
                        Provider.of<TextSizeNotifier>(context, listen: false)
                            .increase();
                      },
                    ),
                    PlatformMenuItem(
                      label: 'Decrease text size',
                      shortcut: const SingleActivator(
                        LogicalKeyboardKey.minus,
                        meta: true,
                      ),
                      onSelected: () {
                        Provider.of<TextSizeNotifier>(context, listen: false)
                            .decrease();
                      },
                    ),
                    PlatformMenuItem(
                      label: 'Reset text size',
                      shortcut: const SingleActivator(
                        LogicalKeyboardKey.digit0,
                        meta: true,
                      ),
                      onSelected: () {
                        Provider.of<TextSizeNotifier>(context, listen: false)
                            .reset();
                      },
                    ),
                  ],
                ),
                PlatformMenuItemGroup(
                  members: <MenuItem>[
                    PlatformMenuItem(
                      label: 'Older journal',
                      shortcut: const SingleActivator(
                        LogicalKeyboardKey.arrowRight,
                        meta: true,
                      ),
                      onSelected: journals.canGoPrevious
                          ? () {
                              journals.previous();
                            }
                          : null,
                    ),
                    PlatformMenuItem(
                      label: 'Newer journal',
                      shortcut: const SingleActivator(
                        LogicalKeyboardKey.arrowLeft,
                        meta: true,
                      ),
                      onSelected: journals.canGoNext
                          ? () {
                              journals.next();
                            }
                          : null,
                    ),
                  ],
                ),
                PlatformMenuItem(
                  label: 'Preferences',
                  shortcut: const SingleActivator(
                    LogicalKeyboardKey.comma,
                    meta: true,
                  ),
                  onSelected: () {
                    Navigator.push(context, Routes.preferences);
                  },
                ),
                if (PlatformProvidedMenuItem.hasMenu(
                  PlatformProvidedMenuItemType.quit,
                ))
                  const PlatformProvidedMenuItem(
                    type: PlatformProvidedMenuItemType.quit,
                  ),
              ],
            ),
          ],
          child: child,
        );
      },
    );
  }
}
