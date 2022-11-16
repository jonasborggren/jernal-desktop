import 'package:flutter/material.dart';
import 'package:jernal/data/notifiers/focus_mode.dart';
import 'package:jernal/data/notifiers/journals.dart';
import 'package:jernal/data/notifiers/onboarding.dart';
import 'package:jernal/data/notifiers/text_size.dart';
import 'package:jernal/utils/extensions.dart';
import 'package:jernal/utils/method_channel.dart';
import 'package:jernal/widgets/common/achievements_ticker.dart';
import 'package:jernal/widgets/common/custom_text_controller.dart';
import 'package:jernal/widgets/common/dialog_confirm.dart';
import 'package:jernal/widgets/common/dialog_journals.dart';
import 'package:jernal/widgets/common/page_wrapper.dart';
import 'package:jernal/widgets/main/focus_mode_toggle.dart';
import 'package:jernal/widgets/main/messenger_wrapper.dart';
import 'package:jernal/widgets/main/text_field.dart';
import 'package:jernal/widgets/onboarding/onboarding.dart';
import 'package:provider/provider.dart';

class MainContent extends StatefulWidget {
  const MainContent({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent>
    with TickerProviderStateMixin {
  late CustomTextEditingController textEditingController;

  final FocusNode textFocusNode = FocusNode(canRequestFocus: true);

  late Animation animation;
  late Animation bgAnimation;
  late AnimationController controller;

  var onChanged = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Consumer4<FocusModeNotifier, JournalNotifier, OnboardingNotifier,
          TextSizeNotifier>(
        builder: (context, focusMode, journals, onboarding, textSize, child) {
          bool doingOnboarding = onboarding.isDoingOnboarding;

          if (journals.currentIndex > 0) {
            final key =
                GlobalObjectKey(journals.currentIndex - 1).currentContext;
            if (key != null) {
              // Scroll to item
              Scrollable.ensureVisible(key);
            }
          }

          final items = journals.items;
          final currentIndex = journals.currentIndex;
          final currentItem = items.isNotEmpty ? items[currentIndex] : null;
          if (textEditingController.text != currentItem?.body) {
            textEditingController.text = currentItem?.body ?? "";
          }

          //if (!isFocusModeEnabled) {
          //  controller.forward();
          //} else {
          //  controller.reverse();
          // }
          buttonForeground(bool enabled) => enabled
              ? context.theme.elevatedButtonTheme.style?.foregroundColor
                  ?.resolve({MaterialState.focused})
              : context.colorScheme.onSurface;
          buttonBackground(MaterialState state) =>
              context.theme.elevatedButtonTheme.style?.backgroundColor
                  ?.resolve({state});
          final numberCounterForeground = context.colorScheme.onSurface;

          const iconSize = 16.0;
          final combinedButtonStyle = ElevatedButton.styleFrom(
            minimumSize: Size.zero,
            shape: const RoundedRectangleBorder(),
            backgroundColor: buttonBackground(MaterialState.disabled),
            shadowColor: Colors.transparent,
            //foregroundColor: context.colorScheme.onSecondary,
            foregroundColor: MaterialStateColor.resolveWith((states) {
              return buttonForeground(
                      states.contains(MaterialState.disabled)) ??
                  context.colorScheme.onSurface;
            }),
            elevation: 0.0,
            padding: const EdgeInsets.only(
              top: 16.0,
              bottom: 16.0,
              left: 8.0,
              right: 8.0,
            ),
          );
          const buttonPadding = EdgeInsets.only(
            left: 6,
            right: 10,
            top: 2,
            bottom: 2,
          );
          final buttonStyle = ElevatedButton.styleFrom(
            minimumSize: Size.zero,
            padding: const EdgeInsets.only(
              left: 4,
              top: 12,
              bottom: 12,
            ),
          );
          final canDelete = currentIndex != 0 ||
              textEditingController.text.isNotEmpty == true;

          return MessengerWrapper(
            child: Stack(
              children: [
                PageWrapper(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Spacer(),
                      Row(
                        children: [
                          Container(
                            height: 32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Row(
                              children: [
                                ElevatedButton(
                                  style: combinedButtonStyle,
                                  onPressed: journals.canGoPrevious
                                      ? () {
                                          journals.previous();
                                        }
                                      : null,
                                  child: const Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    size: iconSize,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: onJournalIndexClicked,
                                  style: combinedButtonStyle.copyWith(
                                    padding: const MaterialStatePropertyAll(
                                      EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 15,
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                    constraints: const BoxConstraints(
                                      minWidth: 12.0,
                                    ),
                                    child: Text(
                                      journals.number.toString(),
                                      textAlign: TextAlign.center,
                                      style: context.theme.textTheme.bodySmall
                                          ?.copyWith(
                                        color: numberCounterForeground,
                                      ),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  style: combinedButtonStyle,
                                  onPressed: journals.canGoNext
                                      ? () {
                                          journals.next();
                                        }
                                      : null,
                                  child: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: iconSize,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          ElevatedButton(
                            style: buttonStyle,
                            onPressed: canDelete ? onDeleteClicked : null,
                            child: Padding(
                              padding: buttonPadding,
                              child: Icon(
                                Icons.delete_outline_rounded,
                                size: 20,
                                color: canDelete
                                    ? context.colorScheme.error
                                    : null,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          ElevatedButton(
                            style: buttonStyle,
                            onPressed: () {
                              textSize.decrease();
                            },
                            child: const Padding(
                              padding: buttonPadding,
                              child: Icon(
                                Icons.text_decrease_rounded,
                                size: 18,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          ElevatedButton(
                            style: buttonStyle,
                            onPressed: () {
                              textSize.increase();
                            },
                            child: const Padding(
                              padding: buttonPadding,
                              child: Icon(
                                Icons.text_increase_rounded,
                                size: 18,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          ElevatedButton(
                            style: buttonStyle,
                            onPressed: () {
                              textSize.reset();
                            },
                            child: const Padding(
                              padding: buttonPadding,
                              child: Icon(
                                Icons.format_clear_rounded,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                CustomTextField(
                  textEditingController: textEditingController,
                  onChanged: (value) {
                    items[currentIndex].body = value;
                    setState(() {
                      onChanged = true;
                    });
                  },
                ),
                const FocusModeToggle(),
                Container(
                  alignment: Alignment.bottomRight,
                  margin: const EdgeInsets.only(right: 16, bottom: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AchievementsTicker(
                        controller: textEditingController,
                        size: const Size(24, 24),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: textEditingController.text.isNotEmpty
                            ? () {
                                onSaveClicked(currentIndex);
                              }
                            : null,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          child: Text(l10n.save),
                        ),
                      ),
                    ],
                  ),
                ),
                if (doingOnboarding) const Onboarding()
              ],
            ),
          );
        },
      ),
    );
  }

  void onSaveClicked(int currentIndex) async {
    FocusModeNotifier.setFocusModeWith(context, false);
    final text = textEditingController.text.toString();
    if (text.isEmpty) {
      if (currentIndex != 0) {
        // User wants to remove?
        print("remove existing note");
      } else {
        // New note, but empty
        print("new empty note?");
      }
    } else {
      if (currentIndex == 0) {
        // New note!
        print("save new note");
        await JournalNotifier.insertWith(context, text);
      } else {
        await JournalNotifier.updateWith(context, text);
      }
    }
    setState(() {
      onChanged = false;
    });
  }

  void onDeleteClicked() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return ConfirmationDialog(
          dialogContext: dialogContext,
          type: ConfirmationDialogType.deleteJournal,
          onConfirm: () {
            JournalNotifier.deleteWith(context);
          },
          onCancel: () {},
        );
      },
    );
  }

  void onJournalIndexClicked() {
    showDialog(
        context: context,
        builder: (context) {
          return const JournalsDialog();
        });
  }

  @override
  void initState() {
    super.initState();

    methodChannelHandler.channel.setMethodCallHandler((call) async {
      print(call);
      Navigator.of(context).popAndPushNamed("/preferences");
      return null;
    });

    controller = AnimationController(
      upperBound: 1,
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(controller);
    controller.addListener(() {
      setState(() {});
    });
    bgAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(controller);
    controller.forward(from: 1.001);

    final textAnimController = AnimationController(vsync: this);
    textAnimController.duration = const Duration(milliseconds: 25);
    textEditingController = CustomTextEditingController(
        animController: textAnimController,
        doAnimation: () {
          textAnimController.reset();
          textAnimController.forward();
        });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
}
