import 'package:flutter/material.dart';
import 'package:flutter_app_erp/providers/cartProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:flutter_app_erp/widgets/shoppingCart/show_prducts_prices.dart';

class AlertDialogProductsPrices extends StatefulWidget {
  final int orderId;
  final int currencyId;

  const AlertDialogProductsPrices({
    super.key,
    required this.orderId,
    required this.currencyId,
  });

  @override
  _AlertDialogProductsPrices createState() => _AlertDialogProductsPrices();
}

class _AlertDialogProductsPrices extends State<AlertDialogProductsPrices> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final String? token = authProvider.getToken();

    return Dialog.fullscreen(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) =>
                CartProvider(orderId: widget.orderId, token: token as String),
          )
        ],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ShowProductsPrices(
                token: token ?? '',
                currencyId: widget.currencyId,
                orderId: widget.orderId,
              ),
            ),
            //CardProductsPrices(token: token ?? ""),
          ],
        ),
      ),
    );
  }
}
