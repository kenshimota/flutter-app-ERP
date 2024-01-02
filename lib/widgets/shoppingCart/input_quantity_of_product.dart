import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/input_base_app.dart';
import 'package:validatorless/validatorless.dart';

class InputQuantityOfProduct extends StatelessWidget {
  final String? label; 
  final TextEditingController? quantity;
  final Future? future;
  final String? errorText;

  const InputQuantityOfProduct({
    super.key,
    this.label = 'Cantidad',
    this.future,
    this.quantity,
    this.errorText,
  });

  @override
  Widget build(BuildContext context){
    final List<String? Function(String?)> validateQuantity = [
    Validatorless.required('$label es requerido'),
    Validatorless.min(1, "debe ser un numero entero"),
    Validatorless.number("Valor invalido, debe ser numerico")
  ];
    return InputBaseApp(
      enabled: true,
      label: label ?? 'Cantidad',
      controller: quantity,
      future: future,
      errorText: errorText,
      validator: Validatorless.multiple(validateQuantity),
    );
  }
}