import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/http/orders/delete_orders.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:flutter_app_erp/widgets/elevated_button_future.dart';
import 'package:provider/provider.dart';

// ignore: non_constant_identifier_names
Widget DeleteButtonOrders({
  required int orderId,
  required BuildContext context,
  void Function()? onAfterDelete
}) {
  return IconButton(
    onPressed:  () => showDialog(
    context: context,
    barrierDismissible: false, 
    builder: (BuildContext context) => AlertDialogDelete(
      orderId: orderId,
      onAfterDelete: onAfterDelete,
    )),
    icon: const Icon(Icons.delete), 
  );
}

// ignore: non_constant_identifier_names
Widget TextButtonDeleteOrders({
  required int orderId,
  required BuildContext context,
  void Function()? onAfterDelete,
  child,
  Color? color,
}) {
  final style = color == null ? null : TextButton.styleFrom(foregroundColor: color);

  return TextButton(
    style: style,
    onPressed: () => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialogDelete(
        orderId: orderId,
        onAfterDelete: onAfterDelete,
      )
      ),
      child: const Text('Eliminar'),
  );

}

class AlertDialogDelete extends StatefulWidget {
  final int orderId;
  final void Function()? onAfterDelete;

  const AlertDialogDelete({
    super.key,
    required this.orderId,
    this.onAfterDelete,
  });

  @override
  _AlertDialogDelete createState() => _AlertDialogDelete();
}

class _AlertDialogDelete extends State<AlertDialogDelete> {
  Future? _futureDelete;
  String message = 'No se pud eliminar';

  Future<void> onDeleteRequest(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final String? token = authProvider.getToken();

    bool response = await deleteOrders(id: widget.orderId, token: token ?? '');

    if(!context.mounted) {
      return;
    }

    if(response == false){
       showError(context, message);
      return;
    }


    Navigator.pop(context);

    widget.onAfterDelete!();
  }

   void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.error,
        content: Text(message),
      ),
    );
  }

  onDelete(BuildContext context) {
    setState(() {
      _futureDelete = onDeleteRequest(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Eliminar'),
      content: const Text(
          'Esta seguro que deseas eliminar este elemento de la tabla?'),
      actions: [
        ButtonBar(
          children: [
            ElevatedButtonFuture(
              future: _futureDelete,
              onPressed: () => onDelete(context),
              child: const Text('Si'),
            ),
            ElevatedButtonFuture(
              future: _futureDelete,
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