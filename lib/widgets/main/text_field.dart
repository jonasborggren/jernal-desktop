import 'package:flutter/material.dart';
import 'package:jernal/data/notifiers/focus_mode.dart';
import 'package:jernal/data/notifiers/text_size.dart';
import 'package:jernal/utils/extensions.dart';
import 'package:provider/provider.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    required this.onChanged,
    required this.textEditingController,
  }) : super(key: key);

  final TextEditingController textEditingController;
  final Function(String value) onChanged;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField>
    with SingleTickerProviderStateMixin {
  final FocusNode textFocusNode = FocusNode(canRequestFocus: true);
  late ScrollController scrollController;
  late AnimationController animationController;
  late Animation animation;

  @override
  Widget build(BuildContext context) {
    final originalTextSize = context.theme.textTheme.bodyMedium!.fontSize!;
    return Consumer<TextSizeNotifier>(
      builder: (context, notifier, _) {
        return Container(
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
          ),
          child: TextField(
            focusNode: textFocusNode,
            scrollPadding: const EdgeInsets.only(bottom: 100),
            controller: widget.textEditingController,
            scrollController: scrollController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                top: 16.0 + (24.0 * (1.0 - animation.value)),
                left: 16.0 + (1.0 - animation.value),
                right: 16.0 + (1.0 - animation.value),
                bottom: 16.0 + (56.0 * (1.0 - animation.value)),
              ),
              border: InputBorder.none,
              isDense: false,
              hintText: l10n.textFieldHint,
              filled: true,
            ),
            //expands: true,
            //minLines: null,
            //maxLines: null,
            minLines: 1000,
            maxLines: 9999999999,
            keyboardType: TextInputType.multiline,
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.top,
            style: context.theme.textTheme.bodyMedium!.copyWith(
              fontSize: originalTextSize * notifier.textSizeMultiplier,
            ),
            onChanged: (value) {
              widget.onChanged(value);
            },
          ),
        );
      },
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
    notifier.addListener(() {
      if (notifier.isFocusModeEnabled) {
        animationController.reverse();
      } else {
        animationController.forward();
      }
    });
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
