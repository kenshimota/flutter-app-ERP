import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/form_tax.dart';
import 'package:flutter_app_erp/widgets/typography.dart';

class AlertDialogNewTax extends StatefulWidget {
  const AlertDialogNewTax({super.key});
  @override
  _AlertDialogNewTax createState() => _AlertDialogNewTax();
}

class _AlertDialogNewTax extends State<AlertDialogNewTax> {
  onClick() {}

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const TypographyApp(
          text: 'Nuevo impuesto',
          variant: "h2",
        ),
        actions: [
          FormTax(
            onClick: onClick,
            onAfterSave: () => Navigator.pop(context),
          ),
        ]);
  }
}
