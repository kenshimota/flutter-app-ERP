import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/input_base_app.dart';
import 'package:validatorless/validatorless.dart';

class InputPercentage extends StatelessWidget {
  final String? label;
  final TextEditingController? percentage;
   final Future? future;
  final String? errorText;

  const InputPercentage({
    super.key, 
    this.label = 'Porcentage',
    this.future, 
    this.percentage, 
    this.errorText
  });


  @override
  Widget build(BuildContext context) {
   final List<String? Function(String?)> validatePercentage = [
    Validatorless.required('$label es requerido'),
    Validatorless.min(0, "debe ser mayor o igual a 0%"),
    Validatorless.max(100, "debe ser menor o igual a 100%"),
    Validatorless.number("Valor invalido, debe ser numerico")
  ];
    return InputBaseApp(
      enabled: true,
      label: label ?? 'Porcentaje',
      controller: percentage,
      future: future,
      errorText: errorText,
      validator: Validatorless.multiple(validatePercentage),
    );
  }
}
