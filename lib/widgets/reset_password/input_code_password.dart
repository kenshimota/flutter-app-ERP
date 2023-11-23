import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/input_base_app.dart';
import "package:validatorless/validatorless.dart";

class InputCodePassword extends StatelessWidget {
  final bool enabled;
  final String? label;
  final Future? future;
  final String? errorText;
  final String? placeholder;
  final TextEditingController? controller;

  const InputCodePassword({
    super.key,
    this.controller,
    this.placeholder,
    this.label = 'Codigo',
    this.enabled = true,
    this.errorText,
    this.future,
  });

  @override
  Widget build(BuildContext context) {
    final List<String? Function(String?)> listValidations = [
      Validatorless.min(6, "Debe tener al menos 6 digitos"),
      Validatorless.max(6, "Debe tener maximo 6 digitos"),
      Validatorless.number("Debe ser un valor numerico"),
      Validatorless.required("Ingrese el codigo"),
    ];

    return InputBaseApp(
      enabled: enabled,
      label: label,
      future: future,
      errorText: errorText,
      placeholder: placeholder,
      controller: controller,
      validator: Validatorless.multiple(listValidations),
    );
  }
}
