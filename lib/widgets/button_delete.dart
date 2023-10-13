// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/http/taxes/delete_taxes.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:flutter_app_erp/widgets/elevated_button_future.dart';
import 'package:provider/provider.dart';
// lo acabo de colocal

Widget DeleteButtonTaxes(
    {required int taxId,
    required BuildContext context,
    void Function()? onAfterDelete}) {
  return IconButton(
    onPressed: () => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialogDelete(
        taxId: taxId,
        onAfterDelete: onAfterDelete,
      ),
    ),
    icon: const Icon(Icons.delete),
  );
}

Widget TextButtonDeleteTax({
  required int taxId,
  required BuildContext context,
  void Function()? onAfterDelete,
  child,
  Color? color,
}) {
  final style =
      color == null ? null : TextButton.styleFrom(foregroundColor: color);

  return TextButton(
    style: style,
    onPressed: () => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialogDelete(
        taxId: taxId,
        onAfterDelete: onAfterDelete,
      ),
    ),
    child: Text('Eliminar'),
  );
}

/* */

class AlertDialogDelete extends StatefulWidget {
  final int taxId;
  final void Function()? onAfterDelete;

  const AlertDialogDelete({super.key, required this.taxId, this.onAfterDelete});

  @override
  // ignore: library_private_types_in_public_api
  _AlertDialogDelete createState() => _AlertDialogDelete();
}

class _AlertDialogDelete extends State<AlertDialogDelete> {
  Future? _futureDelete;
  String message = 'No se pudo eliminar';

// este funcion espera una respuest
  Future<void> onDeleteRequest(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final String? token = authProvider.getToken();

    debugPrint("before request");

    bool response = await deleteTax(id: widget.taxId, token: token ?? '');

    debugPrint("after request");

    if (!context.mounted) {
      return;
    }

    if (response == false) {
      showError(context, message);
      return;
    }

    Navigator.pop(context);

    // debugPrint(widget.onAfterDelete.toString());

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
