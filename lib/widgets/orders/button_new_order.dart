import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/circular_button.dart';
import 'package:flutter_app_erp/widgets/orders/dialog_new_order.dart';

class ButtonNewOrder extends StatelessWidget {
  final void Function()? onSave;
  final String token;

  const ButtonNewOrder({
    super.key,
    this.onSave,
    required this.token,
    
  }); 

  onNewOrder(BuildContext context,String token) {
    showDialog(
      context: context, 
      builder: (BuildContext context) => AlertDialogNewOrder(
        onSave: onSave,
        token: token,
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
      onPressed: () => onNewOrder(context, token),
    );
  }
}