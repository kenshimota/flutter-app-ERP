import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/typography.dart';
import 'package:flutter_app_erp/widgets/form_tax_update.dart';
import 'package:flutter_app_erp/core/response/taxes/taxes_response.dart';

class AlertDialogEditTax extends StatefulWidget {
  final TaxesResponse tax;
  final void Function()? onSave;

  const AlertDialogEditTax({
    super.key,
    this.onSave,
    required this.tax,
  });

  @override
  _AlertDialogEditTax createState() => _AlertDialogEditTax();
}

class _AlertDialogEditTax extends State<AlertDialogEditTax> {
  void onAfterSave(context) {
    if (context.mounted == false) {
      return;
    }

    Navigator.pop(context);
    widget.onSave!();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const TypographyApp(
          text: 'Editar Impuesto',
          variant: "h3",
        ),
        actions: [
          FormTaxUpdate(
            tax: widget.tax,
            onAfterSave: () => onAfterSave(context),
          ),
        ]);
  }
}
