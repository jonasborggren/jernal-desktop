import 'package:flutter/material.dart';
import 'package:jernal/widgets/common/on_hover.dart';

class OnHoverOrInputChanged extends StatefulWidget {
  const OnHoverOrInputChanged({
    super.key,
    required this.child,
    required this.textEditingController,
  });

  final Widget child;
  final TextEditingController textEditingController;

  @override
  State<OnHoverOrInputChanged> createState() => _OnHoverOrInputChangedState();
}

class _OnHoverOrInputChangedState extends State<OnHoverOrInputChanged> {
  late OnHoverController hoverController;

  @override
  Widget build(BuildContext context) {
    return OnHover(
      controller: hoverController,
      child: widget.child,
    );
  }

  @override
  void initState() {
    super.initState();
    hoverController = OnHoverController();
    widget.textEditingController.addListener(onTextChanged);
  }

  @override
  void dispose() {
    widget.textEditingController.removeListener(onTextChanged);
    hoverController.dispose();
    super.dispose();
  }

  void onTextChanged() {
    //final text = widget.textEditingController.text;
    //print("aarå: $text");
    //hoverController.setDelay(const Duration(seconds: 2));
  }
}
