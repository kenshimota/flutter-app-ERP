import 'package:flutter/material.dart';
import "package:validatorless/validatorless.dart";

class InputUserName extends StatelessWidget {
  final bool enabled;
  final String? label;
  final String? errorText;
  final TextEditingController? controller;

  const InputUserName({
    super.key,
    this.label = 'Usuario',
    this.controller,
    this.enabled = true,
    this.errorText,
  });

  void dispose() {
    controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String? Function(String?)> listValidations = [
      //Validatorless.required('${label} es requerido'),
      //Validatorless.min(3, '${label} es demasiado corto (3 caracteres mínimo)'),
    ];

    return TextFormField(
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
        errorText: errorText,
        hintText: 'minombre-apellido',
      ),
      validator: Validatorless.multiple(listValidations),
      controller: controller,
    );
  }
}
