import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/typography.dart';
import 'package:flutter_app_erp/widgets/form_warehouse_update.dart';
import 'package:flutter_app_erp/core/response/warehouse/warehouse_response.dart';

class AlertDialogEditWarehouse extends StatefulWidget {
  final WarehouseResponse ware;
  final void Function()? onSave;

  const AlertDialogEditWarehouse({
    super.key,
    this.onSave,
    required this.ware,
  });

  @override
  _AlertDialogEditWarehouse createState() => _AlertDialogEditWarehouse();
}

class _AlertDialogEditWarehouse extends State<AlertDialogEditWarehouse> {
  void onAfterSave(context) {
    if (context.mounted == false) {
      return;
    }

    Navigator.pop(context);
    widget.onSave!();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const TypographyApp(
          text: 'Editar Deposito',
          variant: "h3",
        ),
        actions: [
          FormWarehouseUpdate(
            ware: widget.ware,
            onAfterSave: () => onAfterSave(context),
          ),
        ]);
  }
}
