import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/container_white.dart';

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
          child: ContainerWhite(
            radius: 20,
            child: child as Widget,
          ),
        ),
      ),
    );
  }
}
