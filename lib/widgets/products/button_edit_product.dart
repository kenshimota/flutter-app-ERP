import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/products/dialog_edit_product.dart';
import 'package:flutter_app_erp/core/response/products/products_response.dart';

class ButtonEditProduct extends StatelessWidget {
  final void Function()? onSave;
  final ProductsResponse product;

  const ButtonEditProduct({
    super.key,
    this.onSave,
    required this.product,
  });

  onEditProduct(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialogEditProduct(
        product: product,
        onSave: onSave,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onEditProduct(context),
      icon: const Icon(Icons.edit),
    );
  }
}

class TextButtonEditProduct extends StatelessWidget {
  final Color? color;
  final void Function()? onSave;
  final ProductsResponse product;

  const TextButtonEditProduct({
    super.key,
    this.onSave,
    this.color,
    required this.product,
  });

  onNewCurrencie(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialogEditProduct(
        product: product,
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
      onPressed: () => onNewCurrencie(context),
      child: const Text('Editar'),
    );
  }
}
