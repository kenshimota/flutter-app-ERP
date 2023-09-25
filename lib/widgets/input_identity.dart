import 'package:flutter/material.dart';
import "package:validatorless/validatorless.dart";
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class InputIdentityDocumenten extends StatelessWidget {
  final bool enabled;
  final String? label;
  final String? errorText;
  final TextEditingController? controller;

  const InputIdentityDocumenten({
    super.key,
    this.label = 'Documento de identidad',
    this.controller,
    this.enabled = true,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final List<String? Function(String?)> listValidations = [
      /*Validatorless.min(
        7,
        'El documento de identidad debe tener como minimo 7 caracteres',
      ),
      Validatorless.max(10,
          'El documento de identidad debe tener como máximo 10 caracteres.'),*/
    ];

    var maskFormatter = MaskTextInputFormatter(
      mask: '###.###,##',
      filter: {
        "#": RegExp(r'[0-9]'),
      },
    );

    return TextFormField(
      enabled: enabled,
      inputFormatters: [maskFormatter],
      decoration: InputDecoration(
        labelText: label,
        errorText: errorText,
        hintText: '000 000 000',
      ),
      validator: Validatorless.multiple(listValidations),
    );
  }
}
