import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/input_base_app.dart';

class InputExchangeRate extends StatelessWidget {
  final String? label;
  final TextEditingController? exchangeRate;
  final String? errorText;

  const InputExchangeRate(
      {super.key, this.label = 'taza de cambio', this.exchangeRate, this.errorText});

  String? validateExchangeRate(String? value) {
    if (value!.isEmpty) {
      return 'Por favor ingresa la taza de cambio';
    }
    // Verificar si el valor es un número válido
    double exchangeRate;
    try {
      exchangeRate = double.parse(value);
    } catch (e) {
      return 'Por favor ingresa un número válido';
    }
    // Verificar si el valor está dentro del rango de porcentaje válido (0-100)
    if (exchangeRate < 0 || exchangeRate > 100) {
      return 'Por favor ingrese uan taza de cambio válida (entre 0 y 100)';
    }
    return ''; // El valor es válido
  }

  @override
  Widget build(BuildContext context) {
    return InputBaseApp(
      enabled: true,
      label: label ?? 'taza de cambio',
      controller: exchangeRate,
      errorText: errorText,
      validator: validateExchangeRate,
    );

    /*return TextFormField(
      controller: percentage,
      validator: validatePercentage,
      decoration: const InputDecoration(
        labelText: 'Porcentaje',
      ),*/
  }
}