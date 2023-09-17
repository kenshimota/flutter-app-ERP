import 'package:flutter/material.dart';
import "package:validatorless/validatorless.dart";

class InputEmail extends StatelessWidget {
  final String? label;
  final bool? isRequired;

  const InputEmail(
      {super.key, this.isRequired = false, this.label = "Correo Electronico"});

  @override
  Widget build(BuildContext context) {
    final List<String? Function(String?)> listValidations = [
      Validatorless.email('El valor ingresado debe ser un email')
    ];

    if (isRequired == true) {
      listValidations.add(Validatorless.required("El campo es requerido"));
    }

    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: "user@example.com",
      ),
      validator: Validatorless.multiple(listValidations),
    );
  }
}
