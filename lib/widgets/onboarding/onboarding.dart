import 'package:flutter/material.dart';
import 'package:jernal/data/notifiers/onboarding.dart';
import 'package:jernal/utils/extensions.dart';
import 'package:jernal/widgets/common/page_wrapper.dart';
import 'package:provider/provider.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Colors.transparent;
    bool ignoreWrapperPadding = false;
    return Consumer<OnboardingNotifier>(builder: (context, notifier, _) {
      final step = notifier.step;
      Widget child;
      switch (step) {
        case 0:
          backgroundColor = context.colorScheme.surface.withOpacity(.7);
          child = Container(
            key: Key("step$step"),
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  l10n.onboardingFirstTitle,
                  style: context.theme.textTheme.headline1,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.onboardingFirstMessage,
                  style: context.theme.textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  child: Text(l10n.onboardingFirstAction),
                  onPressed: () {
                    notifier.nextStep();
                  },
                ),
                const SizedBox(height: 8),
                InkWell(
                  hoverColor: Colors.transparent,
                  child: Text(
                    l10n.skip,
                    style: context.theme.textTheme.bodySmall!.copyWith(
                      color: context.theme.textTheme.bodySmall!.color!
                          .withOpacity(0.4),
                    ),
                  ),
                  onTap: () {
                    notifier.complete();
                  },
                ),
              ],
            ),
          );
          break;
        case 1:
          backgroundColor = context.colorScheme.surface.withOpacity(.7);
          final bindStyle = context.theme.textTheme.bodySmall;
          child = Container(
            key: Key("step$step"),
            padding: const EdgeInsets.symmetric(horizontal: 40),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  l10n.onboardingSecondTitle,
                  style: context.theme.textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 240),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(l10n.bindsPreferences, style: bindStyle),
                          Text(l10n.bindsPreferencesKey, style: bindStyle),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(l10n.bindsQuickSave, style: bindStyle),
                          Text(l10n.bindsQuickSaveKey, style: bindStyle),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(l10n.bindsFocusToggle, style: bindStyle),
                          Text(l10n.bindsFocusToggleKey, style: bindStyle),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(l10n.bindsTextSizeIncrease, style: bindStyle),
                          Text(l10n.bindsTextSizeIncreaseKey, style: bindStyle),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(l10n.bindsTextSizeDecrease, style: bindStyle),
                          Text(l10n.bindsTextSizeDecreaseKey, style: bindStyle),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(l10n.bindsJournalNewer, style: bindStyle),
                          Text(l10n.bindsJournalNewerKey, style: bindStyle),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(l10n.bindsJournalOlder, style: bindStyle),
                          Text(l10n.bindsJournalOlderKey, style: bindStyle),
                        ],
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        child: Text(l10n.next),
                        onPressed: () {
                          notifier.nextStep();
                        },
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        hoverColor: Colors.transparent,
                        child: Text(
                          l10n.skip,
                          style: context.theme.textTheme.bodySmall!.copyWith(
                            color: context.theme.textTheme.bodySmall!.color!
                                .withOpacity(0.4),
                          ),
                        ),
                        onTap: () {
                          notifier.complete();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
          break;
        case 2:
          ignoreWrapperPadding = true;
          backgroundColor = Colors.transparent;
          child = Container(
            key: Key("step$step"),
            width: double.infinity,
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 50),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        colors: [
                          context.colorScheme.surface,
                          context.colorScheme.surface.withOpacity(.7),
                        ],
                        center: Alignment.topLeft,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 40),
                            const Icon(Icons.arrow_upward_rounded),
                            const SizedBox(width: 16),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Text(
                                l10n.onboardingThirdTitle,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(left: 200),
                          child: Column(
                            children: [
                              ElevatedButton(
                                child: Text(l10n.next),
                                onPressed: () {
                                  notifier.nextStep();
                                },
                              ),
                              const SizedBox(height: 8),
                              InkWell(
                                hoverColor: Colors.transparent,
                                child: Text(
                                  l10n.skip,
                                  style: context.theme.textTheme.bodySmall!
                                      .copyWith(
                                    color: context
                                        .theme.textTheme.bodySmall!.color!
                                        .withOpacity(0.4),
                                  ),
                                ),
                                onTap: () {
                                  notifier.complete();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
          break;
        default:
          backgroundColor = context.colorScheme.surface.withOpacity(.7);
          child = Container(
            key: Key("step$step"),
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  l10n.onboardingFourthTitle,
                  style: context.theme.textTheme.headline1,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.onboardingFourthMessage,
                  style: context.theme.textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  child: Text(l10n.onboardingFourthAction),
                  onPressed: () {
                    notifier.complete();
                  },
                ),
              ],
            ),
          );
          break;
      }
      return AnimatedBuilder(
        animation: animation,
        builder: (context, _) {
          return Opacity(
            opacity: animation.value,
            child: PageWrapper(
              backgroundColor: backgroundColor,
              ignorePadding: ignoreWrapperPadding,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: child,
              ),
            ),
          );
        },
      );
    });
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this);
    animationController.duration = const Duration(seconds: 1);
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    animationController.forward();
  }
}
