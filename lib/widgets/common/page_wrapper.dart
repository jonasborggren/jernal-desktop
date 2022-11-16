import 'package:flutter/material.dart';

class PageWrapper extends StatelessWidget {
  const PageWrapper({
    super.key,
    required this.child,
    this.backgroundColor,
    this.ignorePadding = false,
  });

  final Color? backgroundColor;
  final Widget child;
  final bool ignorePadding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.transparent,
      body: Container(
        padding: EdgeInsets.only(
          left: ignorePadding ? 0.0 : 16,
          bottom: ignorePadding ? 0.0 : 16,
        ),
        child: child,
      ),
    );
  }
}
