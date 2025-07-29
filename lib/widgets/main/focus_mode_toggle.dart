import 'package:flutter/material.dart';
import 'package:jernal/data/notifiers/focus_mode.dart';
import 'package:jernal/utils/extensions.dart';
import 'package:jernal/widgets/common/on_hover.dart';
import 'package:provider/provider.dart';

class FocusModeToggle extends StatefulWidget {
  const FocusModeToggle({super.key});

  @override
  State<FocusModeToggle> createState() => _FocusModeToggleState();
}

class _FocusModeToggleState extends State<FocusModeToggle> {
  late OnHoverController onHoverController;

  @override
  void initState() {
    super.initState();
    onHoverController = OnHoverController();
  }

  @override
  void dispose() {
    onHoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FocusModeNotifier>(
      builder: (context, notifier, _) {
        final isFocusModeEnabled = notifier.isFocusModeEnabled;
        return Container(
          alignment: Alignment.topRight,
          child: OnHover(
            controller: onHoverController,
            child: Container(
              decoration: BoxDecoration(
                color: context.colorScheme.tertiary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                ),
              ),
              padding: const EdgeInsets.all(8),
              child: InkWell(
                radius: 0.0,
                hoverColor: Colors.transparent,
                child: Icon(
                  isFocusModeEnabled ? Icons.unfold_less_rounded : Icons.expand_rounded,
                  color: context.colorScheme.onTertiary,
                ),
                onTap: () {
                  notifier.toggle();
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
