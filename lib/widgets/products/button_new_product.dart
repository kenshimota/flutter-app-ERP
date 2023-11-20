import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/circular_button.dart';
import 'package:flutter_app_erp/widgets/products/dialog_new_product.dart';

class ButtonNewProduct extends StatelessWidget {
  final void Function()? onSave;
  const ButtonNewProduct({
    super.key,
    this.onSave,
  });

  onNewProduct(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialogNewProduct(
        onSave: onSave,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CircularButton(
      icon: const Icon(
        Icons.add,
        color: Colors.white,
      ),
      context: context,
      onPressed: () => onNewProduct(context),
    );
  }
}
