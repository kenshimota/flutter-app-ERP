import 'package:flutter/material.dart';
import "package:validatorless/validatorless.dart";

class InputName extends StatelessWidget {
  final bool enabled;
  final String? label;
  final bool? isRequired;
  final String? placeholder;
  final String? errorText;
  final TextEditingController? controller;

  const InputName({
    super.key,
    this.controller,
    this.placeholder,
    this.label = 'Nombre',
    this.isRequired = false,
    this.enabled = true,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final List<String? Function(String?)> listValidations = [
      Validatorless.min(3, "${label} debe tener al menos 3 letras"),
      Validatorless.max(20, "${label} debe maximo 20 letras"),
    ];

    if (isRequired == true) {
      listValidations.add(Validatorless.required("El campo es requerido"));
    }

    return TextFormField(
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
        errorText: errorText,
        hintText: placeholder,
      ),
      controller: controller,
      validator: Validatorless.multiple(listValidations),
    );
  }
}
