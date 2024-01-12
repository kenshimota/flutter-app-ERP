import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/exception/form_errors.dart';
import 'package:flutter_app_erp/widgets/products_prices/form_product_price.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_erp/widgets/form_currencies.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import "package:flutter_app_erp/core/exception/auth_errors.dart";
import 'package:flutter_app_erp/core/http/products_prices/create_products_prices.dart';

class FormProductPriceCreate extends StatefulWidget {
  final void Function()? onAfterSave;

  const FormProductPriceCreate({
    super.key,
    this.onAfterSave,
  });

  @override
  State<FormProductPriceCreate> createState() => _FormProductPriceCreate();
}

class  _FormProductPriceCreate extends State<FormProductPriceCreate>{
  FormErrors errors = FormErrors(map: {});


  void onRequest({
    required BuildContext context,
    required Map<String, dynamic> params,
  }) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final String? token = authProvider.getToken();
    try {
      await createProductPrice(
        token: token as String,
        currencyId: params["currency_id"],
        productId: params["product_id"],
        price: params["price"],
      );

      if (!context.mounted) {
        return;
      }
      widget.onAfterSave!();
    } on AuthErrors {
      authProvider.signOut();
    } on FormErrors catch (e) {
      setState(() {
        errors = e;
      });
    }
  }

  @override
  Widget build(BuildContext context){
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final String? token = authProvider.getToken();
    return FormProductPrice(
      errors: errors,
      token: token as String,
      onRequest: (Map<String, dynamic> params) async => onRequest(
        context: context, 
        params: params
      ),
    );
  }
}