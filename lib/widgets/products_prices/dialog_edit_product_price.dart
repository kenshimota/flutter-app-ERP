import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/response/products_prices/products_prices_response.dart';
import 'package:flutter_app_erp/widgets/products_prices/form_product_price_update.dart';
import 'package:flutter_app_erp/widgets/typography.dart';


class AlertDialogEditProductPrice extends StatefulWidget {
  final ProductsPricesResponse productPrice;
  final void Function()? onSave;
  const AlertDialogEditProductPrice({
    super.key,
    this.onSave,
    required this.productPrice,
  });

  @override 
  State<AlertDialogEditProductPrice> createState() => _AlertDialogProductPrice();
}

class _AlertDialogProductPrice extends State<AlertDialogEditProductPrice>{
  void onAfterSave(context){
    if(context.mounted == false){
      return;
    }
    Navigator.pop(context);
    widget.onSave!();
  }
  
  
  @override 
  Widget build(BuildContext context){
    return AlertDialog(
        title: const TypographyApp(
          text: 'Editar Deposito',
          variant: "h2",
        ),
        actions: [
          FormProductPriceUpdate(
            productPrice: widget.productPrice,
            onAfterSave: () => onAfterSave(context),
          ),
        ]);
  }
}