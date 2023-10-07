import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/form_tax.dart';





class AlertDialogNewTax extends StatefulWidget{
  const AlertDialogNewTax({ super.key });
  @override
  _AlertDialogNewTax createState() => _AlertDialogNewTax();
}

class _AlertDialogNewTax extends State<AlertDialogNewTax>{
  @override
  Widget build(BuildContext context){
    return const AlertDialog(
      title: Text('Nuevo impuesto'),
      //content: Text(''),
      actions:  [
        FormTax(),
      ]
      
    );
  }
}