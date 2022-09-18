import 'package:flutter/material.dart';

class OnHover extends StatefulWidget {
  const OnHover({super.key, required this.child});

  final Widget child;

  @override
  State<OnHover> createState() => _OnHoverState();
}

class _OnHoverState extends State<OnHover> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  var isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: MouseCursor.uncontrolled,
      onEnter: (e) {
        setState(() {
          isHovering = true;
          controller.forward();
        });
      },
      onExit: (e) {
        setState(() {
          isHovering = false;
          controller.reverse();
        });
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
      begin: isHovering == false ? 0.0 : 1.0,
      end: isHovering == false ? 1.0 : 0.0,
    ).animate(controller);
    controller.addListener(() {
      setState(() {});
    });
    controller.reverse();
  }
}
