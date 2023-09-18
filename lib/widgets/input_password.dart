import 'package:flutter/material.dart';
import "package:validatorless/validatorless.dart";

class InputPassword extends StatefulWidget {
  final String? label;
  final String? Function(String?)? validator;

  const InputPassword({super.key, this.label, this.validator});

  @override
  State<InputPassword> createState() => _InputPassword();
}

class _InputPassword extends State<InputPassword> {
  bool visible = false;

  String? _createValidor(String? m) {
    final String? Function(String?)? v = widget.validator;

    if (v == null) {
      return null;
    }

    return v(m);
  }

  invertVisible() {
    setState(() {
      visible = !visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String? label = widget.label;
    final RegExp regExp = RegExp(
        r"/(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-.]).{8,20}/");

    final List<String? Function(String?)> listValidations = [
      Validatorless.min(8, 'Password must be at least 8 characters'),
      Validatorless.max(20, 'Password must be at most 20 characters'),
      Validatorless.regex(regExp,
          "La contraseña debe tener al menos una letra mayuscula, una minuscula, debe tener uno o varios numeros 0-9 y un caracter especial")
    ];

    if (widget.validator != null) {
      listValidations.add(_createValidor);
    }

    return TextFormField(
      obscureText: !visible,
      decoration: InputDecoration(
        labelText: label ?? "Contraseña",
        hintText: 'Enter your Password',
        suffixIcon: IconButton(
          icon: Icon(
            visible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: invertVisible,
        ),
      ),
      validator: Validatorless.multiple(listValidations),
    );
  }
}
