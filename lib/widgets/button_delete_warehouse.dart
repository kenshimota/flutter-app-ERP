import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/http/warehouse/delete_warehouse.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:flutter_app_erp/widgets/elevated_button_future.dart';
import 'package:flutter_app_erp/widgets/typography.dart';
import 'package:provider/provider.dart';

// ignore: non_constant_identifier_names
Widget ButtonDeleteWarehouse(
    {required int wareId,
    required BuildContext context,
    void Function()? onAfterDelete}) {
  return IconButton(
    onPressed: () => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialogDelete(
              wareId: wareId,
              onAfterDelete: onAfterDelete,
            )),
    icon: const Icon(Icons.delete),
  );
}

class AlertDialogDelete extends StatefulWidget {
  final int wareId;
  final void Function()? onAfterDelete;

  const AlertDialogDelete(
      {super.key, required this.wareId, this.onAfterDelete});

  @override
  // ignore: library_private_types_in_public_api
  _AlertDialogDelete createState() => _AlertDialogDelete();
}

class _AlertDialogDelete extends State<AlertDialogDelete> {
  Future? _futureDelete;
  String message = '';

// este funcion espera una respuest
  Future<void> onDeleteRequest(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final String? token = authProvider.getToken();

    setState(() {
      message = '';
    });

    try {
      await deteleWarehouse(id: widget.wareId, token: token ?? '');

      if (!context.mounted) {
        return;
      }

      Navigator.pop(context);

      widget.onAfterDelete!();
    } on String catch (e) {

      debugPrint('$e');
      setState(() {
        message = e;
      });
    }
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

  Widget buildContent() {
    if (message.isEmpty) {
      return const Text(
          'Esta seguro que deseas eliminar este elemento de la tabla?');
    }

    return TypographyApp(text: message, variant: "subtitle2", color: "error");
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Eliminar'),
      content: buildContent(),
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
