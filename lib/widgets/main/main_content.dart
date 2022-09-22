import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jernal/data/notifiers/focus_mode.dart';
import 'package:jernal/data/notifiers/journals.dart';
import 'package:jernal/data/notifiers/onboarding.dart';
import 'package:jernal/data/notifiers/text_size.dart';
import 'package:jernal/routes/routes_main.dart';
import 'package:jernal/utils/extensions.dart';
import 'package:jernal/widgets/common/achievements_ticker.dart';
import 'package:jernal/widgets/common/custom_text_controller.dart';
import 'package:jernal/widgets/common/dialog_confirm.dart';
import 'package:jernal/widgets/common/page_wrapper.dart';
import 'package:jernal/widgets/main/focus_mode_toggle.dart';
import 'package:jernal/widgets/main/journals_list.dart';
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
      body: Consumer3<FocusModeNotifier, JournalNotifier, OnboardingNotifier>(
        builder: (context, focusMode, journals, onboarding, child) {
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
          return Stack(
            children: [
              PageWrapper(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const JournalsSelectableList(),
                    const Expanded(child: Text("")),
                    Row(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: const EdgeInsets.only(
                              top: 12,
                              bottom: 12,
                            ),
                            backgroundColor: context.colorScheme.error,
                          ),
                          onPressed: currentIndex != 0 ||
                                  textEditingController.text.isNotEmpty == true
                              ? onDeleteClicked
                              : null,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            child: Icon(
                              Icons.delete_outline_rounded,
                              size: 20,
                              color: context.colorScheme.onError,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.zero,
                            backgroundColor: context.colorScheme.secondary,
                            foregroundColor: context.colorScheme.onSecondary,
                            padding: const EdgeInsets.only(
                              left: 4,
                              top: 12,
                              bottom: 12,
                            ),
                          ),
                          onPressed: () {
                            TextSizeNotifier.decreaseWith(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            child: Icon(
                              Icons.text_decrease_rounded,
                              size: 18,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.zero,
                            backgroundColor: context.colorScheme.secondary,
                            foregroundColor: context.colorScheme.onSecondary,
                            padding: const EdgeInsets.only(
                              left: 4,
                              top: 12,
                              bottom: 12,
                            ),
                          ),
                          onPressed: () {
                            TextSizeNotifier.increaseWith(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            child: Icon(
                              Icons.text_increase_rounded,
                              size: 18,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.zero,
                            backgroundColor: context.colorScheme.secondary,
                            foregroundColor: context.colorScheme.onSecondary,
                            padding: const EdgeInsets.only(
                              left: 4,
                              top: 12,
                              bottom: 12,
                            ),
                          ),
                          onPressed: () {
                            TextSizeNotifier.resetWith(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
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
                  if (!onChanged) {
                    setState(() {
                      onChanged = true;
                    });
                  }
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
                    /*OnHoverOrInputChanged(
                      textEditingController: textEditingController,
                      child: */
                    ElevatedButton(
                      onPressed:
                          onChanged && textEditingController.text.isNotEmpty
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
                      /*),*/
                    ),
                  ],
                ),
              ),
              if (doingOnboarding) const Onboarding()
            ],
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

  @override
  void initState() {
    super.initState();

    const MethodChannel("jernal").setMethodCallHandler((call) async {
      print(call);
      Navigator.of(context).push(Routes.preferences);
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
