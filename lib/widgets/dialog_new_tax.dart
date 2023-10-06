import 'package:flutter/material.dart';





class AlertDialogNewTax extends StatefulWidget{
  const AlertDialogNewTax({ super.key });
  @override
  _AlertDialogNewTax createState() => _AlertDialogNewTax();
}

class _AlertDialogNewTax extends State<AlertDialogNewTax>{
  @override
  Widget build(BuildContext context){
    return const AlertDialog(
      title: Text('Este es mi formulario'),
      content: Text('AlertDialog description'),
      actions:  [
        Text('Hola como estas'),
      ]
      
    );
  }
}