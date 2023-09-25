import 'package:flutter/material.dart';
import "package:validatorless/validatorless.dart";

class InputEmail extends StatelessWidget {
  final String? label;
  final bool enabled;
  final bool? isRequired;
  final String? errorText;
  final TextEditingController? controller;

  const InputEmail({
    super.key,
    this.isRequired = false,
    this.label = "Correo Electronico",
    this.controller,
    this.errorText,
    this.enabled = true,
  });

  void dispose() {
    controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String? Function(String?)> listValidations = [
      Validatorless.email('El valor ingresado debe ser un email')
    ];

    if (isRequired == true) {
      listValidations.add(Validatorless.required("El campo es requerido"));
    }

    return TextFormField(
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
        errorText: errorText,
        hintText: "user@example.com",
      ),
      controller: controller,
      validator: Validatorless.multiple(listValidations),
    );
  }
}
