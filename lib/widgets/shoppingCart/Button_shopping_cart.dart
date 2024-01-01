import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/shoppingCart/alert_dialog_products_prices.dart';


Widget ButtonShoppingCart({
  required BuildContext context,
}) {
  return IconButton(
    onPressed: () => showDialog(
      context: context,
      builder: (BuildContext context) => const AlertDialogProductsPrices() ), 
    icon: const Icon(Icons.shopping_cart),
  );
}
