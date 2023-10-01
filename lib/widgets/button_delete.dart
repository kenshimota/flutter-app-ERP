// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/http/taxes/delete_taxes.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:flutter_app_erp/widgets/ElevatedButtonFuture.dart';
import 'package:provider/provider.dart';


Widget DeleteButtonTaxes({ required int taxId, required BuildContext context  }) {


    return IconButton(
      onPressed: () => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialogDelete(taxId: taxId),
        
      ),
      icon: const Icon(Icons.delete),
    );

}

class AlertDialogDelete extends StatefulWidget {
  final int taxId;

  const AlertDialogDelete({super.key, required this.taxId });

  @override
  // ignore: library_private_types_in_public_api
  _AlertDialogDelete  createState() => _AlertDialogDelete();
}


class _AlertDialogDelete extends State<AlertDialogDelete> {
  Future? _futureDelete;

  onClick() {
    debugPrint('Hola como estas');
  }

// este funcion espera una respuest
  Future<void> onDeleteRequest(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final String? token = authProvider.getToken();

    debugPrint("before request");

    bool response = await deleteTax(id: widget.taxId, token: token ?? '');

    debugPrint("after request");

    if(!context.mounted){
      return;
    }

    if(response == false){
      debugPrint('No se pudo eliminar');
    }

    Navigator.pop(context);
  }

  onDelete(BuildContext context){
    setState(() {
      _futureDelete = onDeleteRequest(context);
    });
  }




  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: const Text('Eliminar'),
      content: const Text('Esta seguro que deseas eliminar este elemento de la tabla?'),
      actions: [
        ButtonBar(
          children: [
            ElevatedButtonFuture(
              future: _futureDelete,
              onPressed: () =>   onDelete(context),
            child: const Text('Si'),
         ),
        ElevatedButtonFuture(
          future:_futureDelete,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('No'),
        ),
      ],
    ),
  ],
);
}

}
