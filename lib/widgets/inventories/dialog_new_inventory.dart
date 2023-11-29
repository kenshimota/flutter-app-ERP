import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/typography.dart';
import 'package:flutter_app_erp/widgets/alert_dialog_app.dart';
import 'package:flutter_app_erp/widgets/inventories/form_inventory_create.dart';

class AlertDialogNewInventory extends StatefulWidget {
  final void Function()? onSave;

  const AlertDialogNewInventory({
    super.key,
    this.onSave,
  });

  @override
  _AlertDialogNewInventory createState() => _AlertDialogNewInventory();
}

class _AlertDialogNewInventory extends State<AlertDialogNewInventory> {
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
      maxHeight: 460,
      title: const TypographyApp(
        text: 'Nuevo Inventario',
        variant: "h5",
      ),
      content: [
        Expanded(
          child: FormInventoryCreate(
            onAfterSave: () => onAfterSave(context),
          ),
        ),
      ],
    );
  }
}
