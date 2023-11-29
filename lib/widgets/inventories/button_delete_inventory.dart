import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/http/inventories/delete_inventory.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:flutter_app_erp/widgets/elevated_button_future.dart';

// ignore: non_constant_identifier_names
Widget ButtonDeleteInventory(
    {required int inventoryId,
    required BuildContext context,
    void Function()? onAfterDelete}) {
  return IconButton(
    onPressed: () => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialogDeleteInventory(
        inventoryId: inventoryId,
        onAfterDelete: onAfterDelete,
      ),
    ),
    icon: const Icon(Icons.delete),
  );
}

class AlertDialogDeleteInventory extends StatefulWidget {
  final int inventoryId;
  final void Function()? onAfterDelete;

  const AlertDialogDeleteInventory(
      {super.key, required this.inventoryId, this.onAfterDelete});

  @override
  // ignore: library_private_types_in_public_api
  _AlertDialogDeleteInventory createState() => _AlertDialogDeleteInventory();
}

class _AlertDialogDeleteInventory extends State<AlertDialogDeleteInventory> {
  Future? _futureDelete;
  String message = 'No se pudo eliminar';

// este funcion espera una respuest
  Future<void> onDeleteRequest(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final String? token = authProvider.getToken();

    bool response =
        await deleteInventory(id: widget.inventoryId, token: token ?? '');

    if (!context.mounted) {
      return;
    }

    if (response == false) {
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
