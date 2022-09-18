import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jernal/data/notifiers/focus_mode.dart';
import 'package:jernal/data/notifiers/journals.dart';
import 'package:jernal/data/notifiers/text_size.dart';
import 'package:jernal/data/routes/routes_main.dart';
import 'package:jernal/data/utils/extensions.dart';
import 'package:jernal/data/widgets/dialog_confirm.dart';
import 'package:jernal/data/widgets/on_hover.dart';
import 'package:jernal/data/widgets/onboarding.dart';
import 'package:jernal/data/widgets/page_wrapper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainContent extends StatefulWidget {
  const MainContent({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent>
    with SingleTickerProviderStateMixin {
  ScrollController? scrollController;
  TextEditingController? textEditingController;

  final FocusNode textFocusNode = FocusNode(canRequestFocus: true);
  bool doingOnboarding = false;

  late Animation animation;
  late Animation bgAnimation;
  late AnimationController controller;

  var onChanged = false;

  @override
  Widget build(BuildContext context) {
    final titleTheme = Theme.of(context).textTheme.headlineLarge!;
    final originalTextSize = context.theme.textTheme.bodyMedium!.fontSize!;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Consumer2<FocusModeNotifier, JournalNotifier>(
        builder: (context, focusMode, journals, child) {
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
          if (textEditingController?.text != currentItem?.body) {
            textEditingController?.text = currentItem?.body ?? "";
          }

          final isFocusModeEnabled = focusMode.isFocusModeEnabled;

          if (!isFocusModeEnabled) {
            controller.forward();
          } else {
            controller.reverse();
          }
          return Stack(
            children: [
              PageWrapper(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: 48,
                      child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return const SizedBox(width: 8);
                          },
                          scrollDirection: Axis.horizontal,
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final opacity = currentIndex == index ? 1.0 : 0.5;
                            final item = items[index];
                            final actualIndex = items.length - index;
                            return Tooltip(
                              key: GlobalObjectKey(index),
                              message: item.timestamp.toIso8601String(),
                              waitDuration: const Duration(seconds: 1),
                              child: InkWell(
                                radius: 16,
                                hoverColor: Colors.transparent,
                                onTap: () {
                                  selectItem(index);
                                },
                                child: Text(
                                  "#$actualIndex",
                                  style: titleTheme.copyWith(
                                    color:
                                        titleTheme.color!.withOpacity(opacity),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
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
                          ),
                          onPressed: currentIndex != 0 ||
                                  textEditingController?.text.isNotEmpty == true
                              ? onDeleteClicked
                              : null,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            child: Icon(
                              Icons.delete_outline_rounded,
                              size: 20,
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
              Container(
                margin: EdgeInsets.only(
                  left: 16.0 * animation.value,
                  top: 80.0 * animation.value,
                  right: 16.0 * animation.value,
                  bottom: 64.0 * animation.value,
                ),
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(50),
                      blurRadius: 4,
                    ),
                  ],
                  /*
                  border: Border.all(
                    strokeAlign: StrokeAlign.outside,
                    color: context.colorScheme.onSurfaceVariant,
                  ),*/
                ),
                child: Consumer<TextSizeNotifier>(
                    builder: (context, notifier, widget) {
                  return TextField(
                      expands: true,
                      focusNode: textFocusNode,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                          top: 16.0 + (32.0 * (1.0 - animation.value)),
                          left: 16.0 + (16.0 * (1.0 - animation.value)),
                          right: 16.0 + (16.0 * (1.0 - animation.value)),
                          bottom: 0,
                        ),
                        border: InputBorder.none,
                        hintText: "Start writing about your day..",
                      ),
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.top,
                      controller: textEditingController,
                      maxLines: null,
                      minLines: null,
                      style: context.theme.textTheme.bodyMedium!.copyWith(
                        fontSize:
                            originalTextSize * notifier.textSizeMultiplier,
                      ),
                      scrollController: scrollController,
                      onChanged: (value) {
                        items[currentIndex].body = value;
                        setState(() {});
                        onChanged = true;
                      });
                }),
              ),
              Container(
                alignment: Alignment.topRight,
                child: OnHover(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                      ),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: InkWell(
                      radius: 0.0,
                      hoverColor: Colors.transparent,
                      child: Icon(
                        isFocusModeEnabled
                            ? Icons.unfold_less_rounded
                            : Icons.expand_rounded,
                      ),
                      onTap: () {
                        setFocusMode();
                      },
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                margin: const EdgeInsets.only(right: 16, bottom: 16),
                child: ElevatedButton(
                  onPressed: onChanged
                      ? () {
                          onSaveClicked(currentIndex);
                        }
                      : null,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: Text("Save"),
                  ),
                ),
              ),
              if (doingOnboarding)
                Onboarding(
                  onCompleted: () {
                    setState(() {
                      doingOnboarding = false;
                      SharedPreferences.getInstance().then((prefs) {
                        prefs.setBool("onboarding_done", true);
                      });
                    });
                  },
                  onSkip: () {
                    setState(() {
                      doingOnboarding = false;
                      SharedPreferences.getInstance().then((prefs) {
                        prefs.setBool("onboarding_done", true);
                      });
                    });
                    // sharedprefs
                  },
                )
            ],
          );
        },
      ),
    );
  }

  void selectItem(int index) {
    JournalNotifier.setWith(context, index);
  }

  void setFocusMode([bool? enabled]) {
    if (enabled != null) {
      FocusModeNotifier.setFocusModeWith(context, enabled);
    } else {
      FocusModeNotifier.toggleWith(context);
    }
  }

  void onSaveClicked(int currentIndex) async {
    setFocusMode(false);
    final text = textEditingController?.text.toString();
    if (text == null) return; // Something went wrong
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
          onConfirm: () {},
          onCancel: () {},
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    textEditingController = TextEditingController();

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

    SharedPreferences.getInstance().then((prefs) {
      final onboardingDone = prefs.getBool("onboarding_done");
      if (onboardingDone == false || onboardingDone == null) {
        Future.delayed(const Duration(seconds: 2)).then((_) {
          setState(() {
            doingOnboarding = true;
            setFocusMode(false);
          });
        });
      }
    });
  }

  @override
  void dispose() {
    scrollController?.dispose();
    textEditingController?.dispose();
    super.dispose();
  }
}
