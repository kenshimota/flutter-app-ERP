import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/exception/auth_errors.dart';
import 'package:flutter_app_erp/core/http/products_prices/update_product_prices.dart';
import 'package:flutter_app_erp/core/response/products_prices/products_prices_response.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_erp/widgets/products_prices/form_product_price.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';


class FormProductPriceUpdate extends StatelessWidget{
  final ProductsPricesResponse productPrice;
  final void Function()? onAfterSave;

  const  FormProductPriceUpdate({
    super.key,
    this.onAfterSave,
    required this.productPrice,
  });

   void onSubmitRequest({
    required BuildContext context,
    required Map<String, dynamic> params,
  }) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      final String? token = authProvider.getToken();

      await updateProductPrice(
        id: productPrice.id,
        token: token as String,
        currencyId: params["currency_id"],
        productId: params["product_id"],
        price: params["price"],
      );

      if (!context.mounted) {
        return;
      }

      onAfterSave!();
    } on AuthErrors {
      authProvider.signOut();
    }
  }




  @override
  Widget build(BuildContext context){
     final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final String? token = authProvider.getToken();
    return FormProductPrice(
      token: token as String,
      onRequest: (Map<String, dynamic> params) async => onSubmitRequest(
        context: context,
        params: params,
      )
    );
  }
}