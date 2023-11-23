import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/typography.dart';
import 'package:flutter_app_erp/widgets/alert_dialog_app.dart';
import 'package:flutter_app_erp/widgets/products/form_product_update.dart';
import 'package:flutter_app_erp/core/response/products/products_response.dart';

class AlertDialogEditProduct extends StatefulWidget {
  final void Function()? onSave;
  final ProductsResponse product;

  const AlertDialogEditProduct({
    super.key,
    this.onSave,
    required this.product,
  });

  @override
  _AlertDialogEditProduct createState() => _AlertDialogEditProduct();
}

class _AlertDialogEditProduct extends State<AlertDialogEditProduct> {
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
        text: 'Editar Producto',
        variant: "h4",
      ),
      content: [
        Expanded(
          child: FormProductUpdate(
            id: widget.product.id,
            nameDefault: widget.product.name,
            codeDefault: widget.product.code,
            barCodeDefault: widget.product.barCode,
            onAfterSave: () => onAfterSave(context),
          ),
        ),
      ],
    );
  }
}
