import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/shoppingCart/alert_dialog_products_prices.dart';

Widget buttonShoppingCart({
  required int orderId,
  required int currencyId,
  required BuildContext context,
}) {
  return IconButton(
    onPressed: () => showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialogProductsPrices(
        currencyId: currencyId,
        orderId: orderId,
      ),
    ),
    icon: const Icon(Icons.shopping_cart),
  );
}
