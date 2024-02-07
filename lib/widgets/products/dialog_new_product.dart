import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/alert_dialog_app.dart';
import 'package:flutter_app_erp/widgets/products/form_product_create.dart';
import 'package:flutter_app_erp/widgets/typography.dart';

class AlertDialogNewProduct extends StatefulWidget {
  final void Function()? onSave;

  const AlertDialogNewProduct({
    super.key,
    this.onSave,
  });

  @override
  _AlertDialogNewProduct createState() => _AlertDialogNewProduct();
}

class _AlertDialogNewProduct extends State<AlertDialogNewProduct> {
  void onAfterSave(context) {
    if (context.mounted == false) {
      return;
    }

    Navigator.pop(context);
    widget.onSave!();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialogApp(
      maxHeight: 460,
      title: const TypographyApp(
        text: 'Nuevo Producto',
        variant: "h3",
      ),
      content: [
        Expanded(
          child: FormProductCreate(
            onAfterSave: () => onAfterSave(context),
          ),
        ),
      ],
    );
  }
}
