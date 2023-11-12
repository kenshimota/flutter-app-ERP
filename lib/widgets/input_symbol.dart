import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/input_base_app.dart';
import "package:validatorless/validatorless.dart";

class InputSymbol extends StatelessWidget {
  final bool enabled;
  final String? label;
  final bool? isRequired;
  final String? placeholder;
  final String? errorText;
  final Future? future;
  final TextEditingController? controller;

  const InputSymbol({
    super.key,
    this.controller,
    this.placeholder,
    this.label = 'Symbol',
    this.isRequired = false,
    this.enabled = true,
    this.errorText,
    this.future,
  });

  @override
  Widget build(BuildContext context) {
    final List<String? Function(String?)> listValidations = [];
    listValidations.add(Validatorless.required("El campo es requerido"));

    

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