import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/input_base_app.dart';
import "package:validatorless/validatorless.dart";

class InputPassword extends StatefulWidget {
  final String? label;
  final Future? future;
  final String? errorText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const InputPassword({
    super.key,
    this.label,
    this.controller,
    this.validator,
    this.errorText,
    this.future,
  });

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

    final List<String? Function(String?)> listValidations = [
      Validatorless.required("La contraseña es requerida"),
      Validatorless.min(8, 'Debe tener mas de 8 caracteres'),
      Validatorless.max(20, 'Debe tener menos de 20 caracteres'),
      Validatorless.regex(
          RegExp(r"(?=.*?[A-Z])"), "Debe tener una letra mayuscula"),
      Validatorless.regex(
          RegExp(r"(?=.*?[a-z])"), "Debe tener una letra minuscula"),
      Validatorless.regex(RegExp(r"(?=.*?[0-9])"), "Debe tener un número"),
      Validatorless.regex(RegExp(r"(?=.*?[#?!@$%^&*-.])"),
          "Debe tener un caracter especial como # ? ! @ &*-."),
    ];

    if (widget.validator != null) {
      listValidations.add(_createValidor);
    }

    return InputBaseApp(
      future: widget.future,
      obscureText: !visible,
      controller: widget.controller,
      errorText: widget.errorText,
      label: label ?? "Contraseña",
      placeholder: 'Ingrese su contraseña',
      suffixIcon: IconButton(
        icon: Icon(
          visible ? Icons.visibility : Icons.visibility_off,
        ),
        onPressed: invertVisible,
      ),
      validator: Validatorless.multiple(listValidations),
    );
  }
}
