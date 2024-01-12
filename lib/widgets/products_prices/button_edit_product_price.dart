import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/products/dialog_edit_product.dart';
import 'package:flutter_app_erp/widgets/products_prices/dialog_edit_product_price.dart';
import 'package:flutter_app_erp/core/response/products_prices/products_prices_response.dart';


class ButtonEditProductPrice extends StatelessWidget {
  final void Function()? onSave;
  final ProductsPricesResponse productPrice;

  const ButtonEditProductPrice({
    super.key,
    this.onSave,
    required this.productPrice,
  });


  onNewProductPrice(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialogEditProductPrice(
        productPrice: productPrice,
        onSave: onSave,
      ),
    );
  }


  @override
  Widget build(BuildContext context){
    return  IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () => onNewProductPrice(context),
    );
  }
}


class TextButtonEditProductPrice extends StatelessWidget {
  final void Function()? onSave;
  final ProductsPricesResponse productPrice;
  final Color? color;

  const TextButtonEditProductPrice({
    super.key,
    this.onSave,
    this.color,
    required this.productPrice,
  });

onNewProductPrice(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialogEditProductPrice(
        productPrice: productPrice,
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
      onPressed: () => onNewProductPrice(context),
      child: const Text('Editar'),
    );
  }
}