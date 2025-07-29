import 'package:flutter/material.dart';
import 'package:jernal/data/notifiers/focus_mode.dart';
import 'package:jernal/utils/extensions.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.onChanged,
    required this.textEditingController,
    required this.constraints,
  });

  final TextEditingController textEditingController;
  final Function(String value) onChanged;
  final BoxConstraints constraints;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> with SingleTickerProviderStateMixin {
  final FocusNode textFocusNode = FocusNode(canRequestFocus: true);
  late ScrollController scrollController;
  late AnimationController animationController;
  late Animation animation;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: widget.constraints,
      margin: EdgeInsets.only(
        bottom: 64.0 * animation.value,
      ),
      padding: EdgeInsets.only(
        top: 20.0,
      ),
      height: widget.constraints.maxHeight,
      width: widget.constraints.maxWidth,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            blurRadius: 4,
          ),
        ],
      ),
      child: TextField(
        focusNode: textFocusNode,
        controller: widget.textEditingController,
        scrollController: scrollController,
        style: context.theme.textTheme.bodyMedium,
        onChanged: (value) {
          widget.onChanged(value);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(animationController);
    animationController.addListener(() {
      setState(() {});
    });

    final notifier = FocusModeNotifier.getProvider(context);
    // Listen to focus mode changes
    notifier.addListener(() {
      if (notifier.isFocusModeEnabled) {
        animationController.reverse();
      } else {
        animationController.forward();
      }
    });
    // Set default focus mode state
    if (notifier.isFocusModeEnabled) {
      animationController.reverse(from: 0.0);
    } else {
      animationController.forward(from: 1.0);
    }

    // Listen to text changes
    widget.textEditingController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    animationController.dispose();
    super.dispose();
  }
}
