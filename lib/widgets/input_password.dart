import 'package:flutter/material.dart';
import "package:validatorless/validatorless.dart";

class InputPassword extends StatelessWidget {
  final String? label;
  final String? Function(String?)? validator;

  const InputPassword({super.key, this.label, this.validator});

  String? _createValidor(String? m) {
    final v = validator;

    if (v == null) {
      return null;
    }

    return v(m);
  }

  @override
  Widget build(BuildContext context) {
    final String? label = this.label;
    final RegExp regExp = RegExp(
        r"/(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-.]).{8,20}/");

    final List<String? Function(String?)> listValidations = [
      Validatorless.min(8, 'Password must be at least 8 characters'),
      Validatorless.max(20, 'Password must be at most 20 characters'),
      Validatorless.regex(regExp,
          "La contraseña debe tener al menos una letra mayuscula, una minuscula, debe tener uno o varios numeros 0-9 y un caracter especial")
    ];

    if (validator != null) {
      listValidations.add(_createValidor);
    }

    return TextFormField(
      decoration: InputDecoration(
        labelText: label ?? "Contraseña",
        hintText: 'Enter your Password',
      ),
      validator: Validatorless.multiple(listValidations),
    );
  }
}
