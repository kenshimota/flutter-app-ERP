import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/input_base_app.dart';

class InputPercentage extends StatelessWidget {
  final String? label;
  final TextEditingController? percentage;
  final String? errorText;

  const InputPercentage(
      {super.key, this.label = 'Porcentage', this.percentage, this.errorText});

  String? validatePercentage(String? value) {
    if (value!.isEmpty) {
      return 'Por favor ingresa un porcentaje';
    }
    // Verificar si el valor es un número válido
    double percentage;
    try {
      percentage = double.parse(value);
    } catch (e) {
      return 'Por favor ingresa un número válido';
    }
    // Verificar si el valor está dentro del rango de porcentaje válido (0-100)
    if (percentage < 0 || percentage > 100) {
      return 'Por favor ingresa un porcentaje válido (entre 0 y 100)';
    }
    return ''; // El valor es válido
  }

  @override
  Widget build(BuildContext context) {
    return InputBaseApp(
      enabled: true,
      label: label ?? 'Porcentaje',
      controller: percentage,
      errorText: errorText,
      validator: validatePercentage,
    );

    /*return TextFormField(
      controller: percentage,
      validator: validatePercentage,
      decoration: const InputDecoration(
        labelText: 'Porcentaje',
      ),*/
  }
}
