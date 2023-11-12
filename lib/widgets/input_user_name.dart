import 'package:flutter/material.dart';
import "package:validatorless/validatorless.dart";
import 'package:flutter_app_erp/widgets/input_base_app.dart';

class InputUserName extends StatelessWidget {
  final bool enabled;
  final String? label;
  final Future? future;
  final String? errorText;
  final TextEditingController? controller;

  const InputUserName({
    super.key,
    this.label = 'Usuario',
    this.controller,
    this.enabled = true,
    this.errorText,
    this.future,
  });

  @override
  Widget build(BuildContext context) {
    final List<String? Function(String?)> listValidations = [
      Validatorless.required('$label es requerido'),
      Validatorless.min(3, '$label es demasiado corto (3 caracteres mínimo)'),
    ];

    return InputBaseApp(
      enabled: enabled,
      label: label,
      future: future,
      errorText: errorText,
      placeholder: "minombre-apellido",
      validator: Validatorless.multiple(listValidations),
      controller: controller,
    );
  }
}
