import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/dialog_edit_tax.dart';
import 'package:flutter_app_erp/core/response/taxes/taxes_response.dart';

class ButtonEditTax extends StatelessWidget {
  final void Function()? onSave;
  final TaxesResponse tax;

  const ButtonEditTax({
    super.key,
    this.onSave,
    required this.tax,
  });

  onNewTax(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialogEditTax(
        tax: tax,
        onSave: onSave,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () => onNewTax(context),
    );
  }
}

class TextButtonEditTax extends StatelessWidget {
  final void Function()? onSave;
  final TaxesResponse tax;
  final Color? color;

  const TextButtonEditTax({
    super.key,
    this.onSave,
    this.color,
    required this.tax,
  });

  onNewTax(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialogEditTax(
        tax: tax,
        onSave: onSave,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final style =
        color == null ? null : TextButton.styleFrom(foregroundColor: color);

    return TextButton(
      style: style,
      onPressed: () => onNewTax(context),
      child: const Text('Editar'),
    );
  }
}
