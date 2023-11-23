import 'package:flutter/material.dart';

class ContainerWhite extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double radius;

  const ContainerWhite(
      {super.key, required this.child, this.radius = 8, this.color});

  @override
  Widget build(BuildContext context) {
    final Color background =
        color ?? Theme.of(context).dialogTheme.backgroundColor ?? Colors.white;

    return Container(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: child,
    );
  }
}
