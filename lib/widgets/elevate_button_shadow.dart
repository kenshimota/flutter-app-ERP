import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class ElevatedButtonShadow extends StatefulWidget {
  final Widget? child;
  const ElevatedButtonShadow({super.key, required this.child});

  @override
  State<ElevatedButtonShadow> createState() => _ElevatedButtonShadowState();
}

class _ElevatedButtonShadowState extends State<ElevatedButtonShadow> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          // Cambiar el estado para aplicar la sombra cuando el mouse entra
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          // Cambiar el estado para quitar la sombra cuando el mouse sale
          isHovered = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [],
        ),
        child: widget.child,
      ),
    );
  }
}
