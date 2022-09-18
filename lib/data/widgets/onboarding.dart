import 'package:flutter/material.dart';
import 'package:jernal/data/utils/extensions.dart';
import 'package:jernal/data/widgets/page_wrapper.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({
    super.key,
    required this.onCompleted,
    required this.onSkip,
  });
  final Function onCompleted;
  final Function onSkip;

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding>
    with SingleTickerProviderStateMixin {
  int step = 0;
  late AnimationController animationController;
  late Animation animation;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Colors.transparent;
    bool ignoreWrapperPadding = false;
    Widget child;
    switch (step) {
      case 0:
        backgroundColor = Colors.white70;
        child = Container(
          key: Key("step$step"),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome!",
                style: context.theme.textTheme.headline1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                "I'm very glad you're here. I'll show you a few tips and tricks that are very useful in this app!",
                style: context.theme.textTheme.headline5,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                child: const Text("Let's go!"),
                onPressed: () {
                  onNextStep();
                },
              ),
              const SizedBox(height: 8),
              InkWell(
                hoverColor: Colors.transparent,
                child: Text(
                  "Skip",
                  style: context.theme.textTheme.bodySmall!.copyWith(
                    color: context.theme.textTheme.bodySmall!.color!
                        .withOpacity(0.4),
                  ),
                ),
                onTap: () {
                  widget.onSkip();
                },
              ),
            ],
          ),
        );
        break;
      case 1:
        backgroundColor = Colors.white70;
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
                "First off\nKeyboard binds!",
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
                        Text("Preferences", style: bindStyle),
                        Text("⌘,", style: bindStyle),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Quick save", style: bindStyle),
                        Text("⌘S", style: bindStyle),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Focus mode toggle", style: bindStyle),
                        Text("⇧⌘F", style: bindStyle),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Increase text size", style: bindStyle),
                        Text("⌘+", style: bindStyle),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Decrease text size", style: bindStyle),
                        Text("⌘-", style: bindStyle),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Move to newer journal", style: bindStyle),
                        Text("⌘←", style: bindStyle),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Move to older journal", style: bindStyle),
                        Text("⌘→", style: bindStyle),
                      ],
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      child: const Text("Next"),
                      onPressed: () {
                        onNextStep();
                      },
                    ),
                    const SizedBox(height: 8),
                    InkWell(
                      hoverColor: Colors.transparent,
                      child: Text(
                        "Skip",
                        style: context.theme.textTheme.bodySmall!.copyWith(
                          color: context.theme.textTheme.bodySmall!.color!
                              .withOpacity(0.4),
                        ),
                      ),
                      onTap: () {
                        widget.onSkip();
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
                  decoration: const BoxDecoration(
                    gradient: RadialGradient(
                      colors: [
                        Colors.white,
                        Colors.white70,
                      ],
                      center: Alignment.topLeft,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          SizedBox(width: 40),
                          Icon(Icons.arrow_upward_rounded),
                          SizedBox(width: 16),
                          Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Text(
                              "Here you see the history of your journals!\nThey stack horizontally as the days progress.",
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
                              child: const Text("Next"),
                              onPressed: () {
                                onNextStep();
                              },
                            ),
                            const SizedBox(height: 8),
                            InkWell(
                              hoverColor: Colors.transparent,
                              child: Text(
                                "Skip",
                                style:
                                    context.theme.textTheme.bodySmall!.copyWith(
                                  color: context
                                      .theme.textTheme.bodySmall!.color!
                                      .withOpacity(0.4),
                                ),
                              ),
                              onTap: () {
                                widget.onSkip();
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
        backgroundColor = Colors.white70;
        child = Container(
          key: Key("step$step"),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "You're done!",
                style: context.theme.textTheme.headline1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                "Very nice. Let's get you writing!",
                style: context.theme.textTheme.headline5,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                child: const Text("Start writing!"),
                onPressed: () {
                  widget.onCompleted();
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
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this);
    animationController.duration = const Duration(seconds: 1);
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    animationController.forward();
  }

  void onNextStep() {
    setState(() {
      step++;
    });
  }
}
