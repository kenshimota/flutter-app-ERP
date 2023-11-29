import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/input_base_app.dart';
import "package:validatorless/validatorless.dart";

class InputStock extends StatelessWidget {
  final bool enabled;
  final String? label;
  final Future? future;
  final String? errorText;
  final String? placeholder;
  final TextEditingController? controller;

  const InputStock({
    super.key,
    this.controller,
    this.placeholder,
    this.label = 'Existencia',
    this.enabled = true,
    this.errorText,
    this.future,
  });

  @override
  Widget build(BuildContext context) {
    final List<String? Function(String?)> listValidations = [
      Validatorless.number("Debe ser un valor numerico"),
      Validatorless.required("Ingrese el codigo"),
      Validatorless.min(0, "El valor minimo es 4"),
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
