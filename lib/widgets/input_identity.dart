import 'package:flutter/material.dart';
import "package:validatorless/validatorless.dart";
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class InputIdentityDocumenten extends StatelessWidget {
  final String? label;
  const InputIdentityDocumenten(
      {super.key, this.label = 'Documento de identidad'});

  @override
  Widget build(BuildContext context) {
    final List<String? Function(String?)> listValidations = [
      Validatorless.min(7, 'The ID must have at least 8 characters'),
      Validatorless.max(10,
          'El documento de identidad debe tener como máximo 20 caracteres.'),
    ];

    var maskFormatter = MaskTextInputFormatter(
      mask: '###.###,##',
      filter: {
        "#": RegExp(r'[0-9]'),
      },
    );

    return TextFormField(
      inputFormatters: [maskFormatter],
      decoration: InputDecoration(
        labelText: label,
        hintText: '000 000 000',
      ),
      validator: Validatorless.multiple(listValidations),
    );
  }
}
