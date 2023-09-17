import 'package:flutter/material.dart';

class LayourtCategoriesBuilder extends StatelessWidget {
  final Widget? lg;
  final Widget? md;
  final Widget? sm;
  final Widget? xs;

  const LayourtCategoriesBuilder(
      {super.key, required this.xs, this.lg, this.sm, this.md});

  Widget _createScreen(BuildContext context, BoxConstraints constraints) {
    Widget? node;
    final double maxWidth = constraints.maxWidth;

    if (lg != null && maxWidth >= 1200) {
      node = lg;
    } else if (md != null && maxWidth >= 900) {
      node = md;
    } else if (sm != null && maxWidth >= 600) {
      node = sm;
    } else {
      node = xs;
    }

    return Container(child: node);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: _createScreen);
  }
}
