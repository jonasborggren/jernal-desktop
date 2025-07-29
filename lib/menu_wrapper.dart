import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jernal/data/notifiers/focus_mode.dart';
import 'package:jernal/data/notifiers/journals.dart';
import 'package:jernal/data/notifiers/messenger.dart';
import 'package:jernal/data/notifiers/text_size.dart';
import 'package:jernal/data/notifiers/theme_mode.dart';
import 'package:jernal/routes/routes_main.dart';
import 'package:jernal/utils/extensions.dart';
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
    return Consumer5<JournalNotifier, ThemeModeNotifier, MessageNotifier, TextSizeNotifier, FocusModeNotifier>(
      builder: (context, journals, themeMode, messenger, textSize, focusMode, _) {
        final String themeModeTitle;
        switch (themeMode.mode) {
          case ThemeMode.system:
            themeModeTitle = context.l10n.menuThemeModeAuto;
            break;
          case ThemeMode.dark:
            themeModeTitle = context.l10n.menuThemeModeDark;
            break;
          case ThemeMode.light:
            themeModeTitle = context.l10n.menuThemeModeLight;
            break;
        }

        return PlatformMenuBar(
          menus: [
            PlatformMenu(
              label: 'Jernal',
              menus: [
                PlatformMenuItemGroup(
                  members: [
                    PlatformMenuItem(
                      label: context.l10n.menuAbout,
                      onSelected: () {
                        PackageInfo.fromPlatform().then((packageInfo) {
                          String appName = packageInfo.appName;
                          String version = packageInfo.version;
                          String buildNumber = packageInfo.buildNumber;
                          showAboutDialog(
                            context: context,
                            applicationName: appName,
                            applicationVersion: context.l10n.aboutVersion(
                              version,
                              buildNumber,
                            ),
                            applicationIcon: const Icon(Icons.reddit),
                          );
                        });
                      },
                    ),
                    PlatformMenuItem(
                      label: context.l10n.menuSave,
                      shortcut: const SingleActivator(
                        LogicalKeyboardKey.keyS,
                        meta: true,
                      ),
                      onSelected: () {
                        journals.save();
                      },
                    ),
                    PlatformMenuItem(
                      label: context.l10n.menuToggleFocusMode,
                      shortcut: const SingleActivator(
                        LogicalKeyboardKey.keyF,
                        meta: true,
                        shift: true,
                      ),
                      onSelected: () {
                        focusMode.toggle();
                        messenger.show(
                          title: context.l10n.messagesFocusModeChanged,
                          summary: focusMode.readable(context),
                        );
                      },
                    ),
                    PlatformMenuItem(
                      label: themeModeTitle,
                      shortcut: const SingleActivator(
                        LogicalKeyboardKey.keyT,
                        meta: true,
                      ),
                      onSelected: () {
                        themeMode.next();
                        messenger.show(
                          title: context.l10n.messagesThemeChanged,
                          summary: themeMode.readable(context),
                        );
                      },
                    ),
                  ],
                ),
                PlatformMenuItemGroup(
                  members: [
                    PlatformMenuItem(
                      label: context.l10n.menuTextSizeIncrease,
                      shortcut: const SingleActivator(
                        LogicalKeyboardKey.add,
                        meta: true,
                      ),
                      onSelected: () {
                        textSize.increase();
                        messenger.show(
                          title: context.l10n.messagesTextSizeChanged,
                          summary: textSize.readableSize(context),
                        );
                      },
                    ),
                    PlatformMenuItem(
                      label: context.l10n.menuTextSizeDecrease,
                      shortcut: const SingleActivator(
                        LogicalKeyboardKey.minus,
                        meta: true,
                      ),
                      onSelected: () {
                        textSize.decrease();
                        final mediaQueryData = MediaQuery.of(context);
                        mediaQueryData.textScaler.scale(textSize.scale);
                        messenger.show(
                          title: context.l10n.messagesTextSizeChanged,
                          summary: textSize.readableSize(context),
                        );
                      },
                    ),
                    PlatformMenuItem(
                      label: context.l10n.menuTextSizeReset,
                      shortcut: const SingleActivator(
                        LogicalKeyboardKey.digit0,
                        meta: true,
                      ),
                      onSelected: () {
                        textSize.reset();
                        messenger.show(
                          title: context.l10n.messagesTextSizeReset,
                        );
                      },
                    ),
                  ],
                ),
                PlatformMenuItemGroup(
                  members: [
                    PlatformMenuItem(
                      label: context.l10n.menuStepOlder,
                      shortcut: const SingleActivator(
                        LogicalKeyboardKey.arrowLeft,
                        meta: true,
                      ),
                      onSelected: journals.canGoPrevious
                          ? () {
                              journals.previous();
                            }
                          : null,
                    ),
                    PlatformMenuItem(
                      label: context.l10n.menuStepNewer,
                      shortcut: const SingleActivator(
                        LogicalKeyboardKey.arrowRight,
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
                  label: context.l10n.menuPreferences,
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
