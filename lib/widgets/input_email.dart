import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/input_base_app.dart';
import "package:validatorless/validatorless.dart";

class InputEmail extends StatelessWidget {
  final String? label;
  final bool enabled;
  final bool? isRequired;
  final String? errorText;
  final Future? future;
  final TextEditingController? controller;

  const InputEmail({
    super.key,
    this.enabled = true,
    this.isRequired = false,
    this.label = "Correo Electronico",
    this.controller,
    this.errorText,
    this.future,
  });

  @override
  Widget build(BuildContext context) {
    final List<String? Function(String?)> listValidations = [
      Validatorless.email('El valor ingresado debe ser un email')
    ];

    if (isRequired == true) {
      listValidations.add(Validatorless.required("El campo es requerido"));
    }

    return InputBaseApp(
      enabled: enabled,
      label: label,
      future: future,
      errorText: errorText,
      placeholder: "user@example.com",
      controller: controller,
      validator: Validatorless.multiple(listValidations),
    );
  }
}
