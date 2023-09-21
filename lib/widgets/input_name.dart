import 'package:flutter/material.dart';
import "package:validatorless/validatorless.dart";

class InputName extends StatelessWidget {
  final String? label;
  final bool? isRequired;

  const InputName({super.key, this.label = 'Name', this.isRequired = false});

  @override
  Widget build(BuildContext context) {
    final List<String? Function(String?)> listValidations = [
      Validatorless.required('Name is required'),
      Validatorless.min(3, 'Name must be at least 3 characters'),
      Validatorless.max(20, 'Name must be at least 20 characters'),
    ];

    if (isRequired == true) {
      listValidations.add(Validatorless.required("El campo es requerido"));
    }
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: "Name",
      ),
      validator: Validatorless.multiple(listValidations),
    );
  }
}
