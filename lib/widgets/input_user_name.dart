import 'package:flutter/material.dart';
import "package:validatorless/validatorless.dart";

class InputUserName extends StatelessWidget {
  final String? label;
  const InputUserName({super.key, this.label = 'Username'});

  @override
  Widget build(BuildContext context) {
    final List<String? Function(String?)> listValidations = [
      Validatorless.required('Username is required'),
      Validatorless.min(3, 'Username must be at least 3 characters'),
    ];

    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: 'UserName',
      ),
      validator: Validatorless.multiple(listValidations),
    );
  }
}
