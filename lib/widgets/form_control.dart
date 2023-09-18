import 'package:flutter/material.dart';

class FormControl extends StatelessWidget {
  final Widget? child;

  const FormControl({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(8), child: child);
  }
}
