import 'package:flutter/material.dart';

class OnHover extends StatefulWidget {
  const OnHover({
    super.key,
    required this.child,
    required this.controller,
  });

  final Widget child;
  final OnHoverController controller;

  @override
  State<OnHover> createState() => _OnHoverState();
}

class _OnHoverState extends State<OnHover> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: MouseCursor.uncontrolled,
      onEnter: (e) {
        final prev = widget.controller.value;
        widget.controller.value = prev.copyWith(hovering: true);
      },
      onExit: (e) {
        final prev = widget.controller.value;
        widget.controller.value = prev.copyWith(hovering: false);
      },
      child: Opacity(
        opacity: animation.value,
        child: widget.child,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      upperBound: 1,
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(controller);
    controller.addListener(animListener);
    controller.reverse();
    widget.controller.addListener(onHoverChanged);
  }

  @override
  void dispose() {
    controller.dispose();
    widget.controller.dispose();
    super.dispose();
  }

  void animListener() {
    setState(() {});
  }

  void onHoverChanged() {
    final state = widget.controller.value;
    print("hoverChanged: $state");
    if (!state.hovering) {
      // Hovering
      if (state.delayUntilShow != Duration.zero) {
        controller.reverse();
        Future.delayed(state.delayUntilShow).then((_) {
          final newState = widget.controller.value;
          widget.controller.value = newState.copyWith(
            delayUntilShow: Duration.zero,
          );
        });
      } else {
        controller.reverse();
      }
    } else {
      // Not hovering
      controller.forward();
    }
  }
}

class OnHoverController extends ValueNotifier<OnHoverControllerValue> {
  OnHoverController({bool startValue = false})
      : super(OnHoverControllerValue.empty);

  void setDelay(Duration duration) {
    value = value.copyWith(
      delayUntilShow: duration,
    );
  }
}

class OnHoverControllerValue {
  const OnHoverControllerValue({
    required this.hovering,
    this.delayUntilShow = Duration.zero,
  });

  final bool hovering;
  final Duration delayUntilShow;

  static OnHoverControllerValue get empty => const OnHoverControllerValue(
        hovering: false,
      );

  OnHoverControllerValue copyWith({
    bool? hovering,
    bool? hideable,
    Duration? delayUntilShow,
  }) {
    return OnHoverControllerValue(
      hovering: hovering ?? this.hovering,
      delayUntilShow: delayUntilShow ?? this.delayUntilShow,
    );
  }

  @override
  String toString() {
    return "OnHoverControllerValue: { hovering: $hovering, delayUntilShow: $delayUntilShow }";
  }
}
