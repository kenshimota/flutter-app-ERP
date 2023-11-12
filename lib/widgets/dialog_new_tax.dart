import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/typography.dart';
import 'package:flutter_app_erp/widgets/form_tax_create.dart';

class AlertDialogNewTax extends StatefulWidget {
  final void Function()? onSave;

  const AlertDialogNewTax({
    super.key,
    this.onSave,
  });

  @override
  _AlertDialogNewTax createState() => _AlertDialogNewTax();
}

class _AlertDialogNewTax extends State<AlertDialogNewTax> {
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
          text: 'Nuevo impuesto',
          variant: "h2",
        ),
        actions: [
          FormTaxCreate(
            onAfterSave: () => onAfterSave(context),
          ),
        ]);
  }
}
