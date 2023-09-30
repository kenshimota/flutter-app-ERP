import 'package:flutter/material.dart';
import "package:validatorless/validatorless.dart";
import 'package:flutter_app_erp/widgets/input_base_app.dart';
import 'package:number_text_input_formatter/number_text_input_formatter.dart';

class InputIdentityDocument extends StatelessWidget {
  final bool enabled;
  final String? label;
  final Future? future;
  final String? errorText;
  final TextEditingController? controller;

  const InputIdentityDocument({
    super.key,
    this.label = 'Documento de identidad',
    this.controller,
    this.enabled = true,
    this.errorText,
    this.future,
  });

  @override
  Widget build(BuildContext context) {
    final List<String? Function(String?)> listValidations = [
      Validatorless.min(
        7,
        'El documento de identidad debe tener como minimo 7 caracteres',
      ),
      Validatorless.max(10,
          'El documento de identidad debe tener como máximo 10 caracteres.'),
    ];

    return InputBaseApp(
      enabled: enabled,
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
