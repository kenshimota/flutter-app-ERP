import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/input_base_app.dart';
import "package:validatorless/validatorless.dart";

class InputName extends StatelessWidget {
  final bool enabled;
  final String? label;
  final bool? isRequired;
  final String? placeholder;
  final String? errorText;
  final Future? future;
  final TextEditingController? controller;

  const InputName({
    super.key,
    this.controller,
    this.placeholder,
    this.label = 'Nombre',
    this.isRequired = false,
    this.enabled = true,
    this.errorText,
    this.future,
  });

  @override
  Widget build(BuildContext context) {
    final List<String? Function(String?)> listValidations = [
      Validatorless.min(3, "$label debe tener al menos 3 letras"),
      Validatorless.max(20, "$label debe maximo 20 letras"),
    ];

    if (isRequired == true) {
      listValidations.add(Validatorless.required("El campo es requerido"));
    }

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
