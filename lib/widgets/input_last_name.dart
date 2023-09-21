import 'package:flutter/material.dart';
import "package:validatorless/validatorless.dart";

class InputLasName extends StatelessWidget {
  final String? label;
  final bool? isRequired;

  const InputLasName(
      {super.key, this.label = 'Last Name', this.isRequired = false});

  @override
  Widget build(BuildContext context) {
    final List<String? Function(String?)> listValidations = [
      Validatorless.required('Last is required'),
      Validatorless.min(3, 'Last must be at least 3 characters'),
      Validatorless.max(20, 'Last must be at least 20 characters'),
    ];

    if (isRequired == true) {
      listValidations.add(Validatorless.required("El campo es requerido"));
    }
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: "Last Name",
      ),
      validator: Validatorless.multiple(listValidations),
    );
  }
}
