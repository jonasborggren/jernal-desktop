import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomTextEditingController extends TextEditingController {
  CustomTextEditingController({this.animController, this.doAnimation}) {
    animController?.addListener(animListener);
  }

  bool animationsEnabled = true;

  Function? doAnimation;
  AnimationController? animController;

  void animListener() {
    super.notifyListeners();
  }

  @override
  void notifyListeners() async {
    final prefs = await SharedPreferences.getInstance();
    animationsEnabled = prefs.getBool("prefs_animations_text") ?? true;

    final shorter = lastLength > text.trim().length;
    lastLength = text.trim().length;
    if (!shorter && animationsEnabled) {
      doAnimation?.call();
    }
    //text = buildTextSpan(context: context, withComposing: withComposing)
    super.notifyListeners();
  }

  int lastLength = 0;

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    assert(!value.composing.isValid ||
        !withComposing ||
        value.isComposingRangeValid);
    // If the composing range is out of range for the current text, ignore it to
    // preserve the tree integrity, otherwise in release mode a RangeError will
    // be thrown and this EditableText will be built with a broken subtree.
    if (animationsEnabled) {
      if (!value.isComposingRangeValid || !withComposing) {
        return TextSpan(
          style: style,
          children: [
            if (text.isEmpty) ...{
              const TextSpan(text: "")
            } else ...{
              TextSpan(text: text.substring(0, text.length - 1)),
              TextSpan(
                text: text.substring(text.length - 1, text.length),
                style: TextStyle(
                  color:
                      style?.color?.withOpacity(animController?.value ?? 1.0),
                  fontSize: (style?.fontSize ?? 16.0) *
                      (animController?.value ?? 1.0),
                ),
              ),
            },
          ],
        );
      }
    } else {
      if (!value.isComposingRangeValid || !withComposing) {
        return TextSpan(style: style, text: text);
      }
    }
    final TextStyle composingStyle =
        style?.merge(const TextStyle(decoration: TextDecoration.underline)) ??
            const TextStyle(decoration: TextDecoration.underline);
    return TextSpan(
      style: style,
      children: <TextSpan>[
        TextSpan(text: value.composing.textBefore(value.text)),
        TextSpan(
          style: composingStyle,
          text: value.composing.textInside(value.text),
        ),
        TextSpan(
          text: value.composing.textAfter(value.text),
          style: const TextStyle(
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
