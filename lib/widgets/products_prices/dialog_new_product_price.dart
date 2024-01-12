import 'package:flutter/material.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:flutter_app_erp/widgets/products_prices/form_product_price_create.dart';
import 'package:flutter_app_erp/widgets/typography.dart';
import 'package:flutter_app_erp/widgets/products_prices/form_product_price.dart';
import 'package:provider/provider.dart';

class AlertDialogNewProductPrice extends StatefulWidget {
  final void Function()? onSave;

  const AlertDialogNewProductPrice({
    super.key,this.onSave
  });

  @override
  State<AlertDialogNewProductPrice> createState() => _AlertDialogNewProductPrice();
}


class _AlertDialogNewProductPrice extends State<AlertDialogNewProductPrice>{

  void onAfterSave(context){
    if(context.mounted == false){
      return; 
    }

    Navigator.pop(context);
    widget.onSave!();
  }


  @override
  Widget build(BuildContext context){
    final authProvider = Provider.of<AuthProvider>(context);
    final String? token = authProvider.getToken();
    return AlertDialog(
      title: const TypographyApp(
        text: 'Crear Producto con precio',
        variant: "h2",
      ), 
      actions: [
        FormProductPriceCreate(
          onAfterSave:  () => onAfterSave(context),
        ),
      ],
    );
  }
}