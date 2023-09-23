import 'package:flutter/material.dart';
import "package:validatorless/validatorless.dart";

class InputUserName extends StatelessWidget {
  final String? label;
  final TextEditingController? controller;

  const InputUserName({super.key, this.label = 'Usuario', this.controller});

  void dispose() {
    controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String? Function(String?)> listValidations = [
      Validatorless.required('Username is required'),
      Validatorless.min(3, 'Username must be at least 3 characters'),
    ];

    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: 'minombre-apellido',
      ),
      validator: Validatorless.multiple(listValidations),
      controller: controller,
    );
  }
}
