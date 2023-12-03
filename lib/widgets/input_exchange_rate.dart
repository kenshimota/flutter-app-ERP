import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/input_base_app.dart';

class InputExchangeRate extends StatelessWidget {
  final String? label;
  final TextEditingController? exchangeRate;
  final String? errorText;
 
  final bool? isRequired;
  final String? placeholder;
  final Future? future;
  

  const InputExchangeRate({
    super.key, 
    this.label = 'taza de cambio', 
    this.exchangeRate, 
    this.errorText,
    this.isRequired,
    this.placeholder,
    this.future,
  });

  String? validateExchangeRate(String? value) {
    if (value!.isEmpty) {
      return 'Ingresa la taza de cambio';
    }
    // Verificar si el valor es un número válido
    double exchangeRate;
    try {
      exchangeRate = double.parse(value);
    } catch (e) {
      return 'Ingresa un número válido';
    }
    // Verificar si el valor está dentro del rango de porcentaje válido (0-100)
    if (exchangeRate < 0) {
      return 'Dato invalido';
    }


    return null; // El valor es válido
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