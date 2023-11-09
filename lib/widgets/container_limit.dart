import 'package:flutter/material.dart';

class ContainerLimit extends StatelessWidget {
  final double maxWidth;
  final double maxHeight;
  final double minWidth;
  final double minHeight;
  final Color? color;
  final Widget? child;

  const ContainerLimit({
    super.key,
    this.maxWidth = double.infinity,
    this.maxHeight = double.infinity,
    this.minWidth = 0,
    this.minHeight = 0,
    this.child,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final Color background =
        color ?? Theme.of(context).dialogTheme.backgroundColor ?? Colors.white;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double screenWidth =
        maxWidth == double.infinity || maxWidth <= width ? maxWidth : width;
    double screenHeight = maxHeight == double.infinity || maxHeight <= height
        ? maxHeight
        : height;

    return LimitedBox(
      maxWidth: screenWidth,
      maxHeight: screenHeight,
      child: OverflowBox(
        maxWidth: screenWidth,
        maxHeight: screenHeight,
        minHeight: minHeight,
        minWidth: minWidth,
        child: FractionallySizedBox(
          widthFactor: 1,
          child: Container(
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(20),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
