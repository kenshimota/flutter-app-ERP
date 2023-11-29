import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/response/inventories/inventories_response.dart';
import 'package:flutter_app_erp/widgets/inventories/form_inventory_update.dart';
import 'package:flutter_app_erp/widgets/typography.dart';
import 'package:flutter_app_erp/widgets/alert_dialog_app.dart';

class AlertDialogEditInventory extends StatefulWidget {
  final void Function()? onSave;
  final InventoryResponse inventory;

  const AlertDialogEditInventory({
    super.key,
    this.onSave,
    required this.inventory,
  });

  @override
  _AlertDialogEditInventory createState() => _AlertDialogEditInventory();
}

class _AlertDialogEditInventory extends State<AlertDialogEditInventory> {
  void onAfterSave(context) {
    if (context.mounted == false) {
      return;
    }

    Navigator.pop(context);
    widget.onSave!();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialogApp(
      maxHeight: 300,
      title: const TypographyApp(
        text: 'Editar Inventario',
        variant: "h5",
      ),
      content: [
        Expanded(
          child: FormInventoryUpdate(
            id: widget.inventory.id,
            stockDefault: widget.inventory.stock,
            observationsDefault: widget.inventory.observations,
            onAfterSave: () => onAfterSave(context),
          ),
        ),
      ],
    );
  }
}
