import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/circular_button.dart';
import 'package:flutter_app_erp/widgets/products_prices/dialog_new_product_price.dart';

class ButtonNewProductPrice extends StatelessWidget {
  final void Function()? onSave;
 

  const ButtonNewProductPrice ({
    super.key,
    this.onSave,
  });

   onNewProductPrice(BuildContext context) {
    showDialog(context: context,
      builder: (BuildContext context) => AlertDialogNewProductPrice(
        onSave: onSave,
      ),
    );
  }







  @override
  Widget build(BuildContext context){
    return CircularButton(
      icon: const Icon(
        Icons.add,
        color: Colors.white,
      ), 
      context: context,
      onPressed: () => onNewProductPrice(context),
    );
  }
}