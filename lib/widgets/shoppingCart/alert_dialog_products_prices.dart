import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:flutter_app_erp/widgets/shoppingCart/show_prducts_prices.dart';


class AlertDialogProductsPrices extends StatefulWidget {
  const AlertDialogProductsPrices({
    super.key,
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
      /*  child: MultiProvider(
      providers: [
        
      ],*/
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: ShowProductsPrices(token: token ?? ''),
          ),
          //CardProductsPrices(token: token ?? ""),
        ],
      ),
    );
  }
}
