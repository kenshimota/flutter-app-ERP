import 'package:flutter/material.dart';
import "package:validatorless/validatorless.dart";
import 'package:flutter_app_erp/widgets/input_base_app.dart';
import 'package:number_text_input_formatter/number_text_input_formatter.dart';

class InputIdentityDocument extends StatelessWidget {
  final bool enabled;
  final String? label;
  final Future? future;
  final String? errorText;
  final Widget? prefixIcon;
  final TextEditingController? controller;

  const InputIdentityDocument({
    super.key,
    this.label = 'Documento de identidad',
    this.controller,
    this.enabled = true,
    this.errorText,
    this.future,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final List<String? Function(String?)> listValidations = [
      Validatorless.min(7, 'debe tener minimo 7 caracteres'),
      Validatorless.required("Es requerido"),
      Validatorless.max(10, 'debe tener máximo 10 caracteres'),
      Validatorless.number("El valor ingresado no es numerico"),
    ];

    return InputBaseApp(
      enabled: enabled,
      prefixIcon: prefixIcon,
      inputFormatters: [
        NumberTextInputFormatter(
          decimalDigits: 2,
          decimalSeparator: '.',
          groupSeparator: ',',
        ),
      ],
      label: label,
      future: future,
      controller: controller,
      errorText: errorText,
      placeholder: '1.000.000',
      validator: Validatorless.multiple(listValidations),
    );
  }
}
