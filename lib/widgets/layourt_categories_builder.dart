import 'package:flutter/material.dart';

class LayourtCategoriesBuilder extends StatelessWidget {
  final Widget? lg;
  final Widget? md;
  final Widget? sm;
  final Widget xs;
  final String log;

  const LayourtCategoriesBuilder(
      {super.key, required this.xs, this.lg, this.sm, this.md, this.log = ""});

  Widget _createScreen(BuildContext context, BoxConstraints constraints) {
    Widget node = xs;
    final double maxWidth = constraints.maxWidth;

    if (lg != null && maxWidth >= 1200) {
      node = lg ?? Container();
    } else if (md != null && maxWidth >= 900) {
      node = md ?? Container();
    } else if (sm != null && maxWidth >= 600) {
      node = sm ?? Container();
    }

    return node;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: _createScreen);
  }
}
