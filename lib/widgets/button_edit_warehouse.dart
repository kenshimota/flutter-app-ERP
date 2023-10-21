import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/dialog_edit_warehouse.dart';
import 'package:flutter_app_erp/core/response/warehouse/warehouse_response.dart';

class ButtonEditWarehouse extends StatelessWidget {
  final void Function()? onSave;
  final WarehouseResponse ware;

  const ButtonEditWarehouse({
    super.key,
    this.onSave,
    required this.ware,
  });

  onNewWarehouse(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialogEditWarehouse(
        ware: ware,
        onSave: onSave,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () => onNewWarehouse(context),
    );
  }
}

class TextButtonEditWarehouse extends StatelessWidget {
  final void Function()? onSave;
  final WarehouseResponse ware;
  final Color? color;

  const TextButtonEditWarehouse({
    super.key,
    this.onSave,
    this.color,
    required this.ware,
  });

  onNewWarehouse(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialogEditWarehouse(
        ware: ware,
        onSave: onSave,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final style =
        color == null ? null : TextButton.styleFrom(foregroundColor: color);

    return TextButton(
      style: style,
      onPressed: () => onNewWarehouse(context),
      child: const Text('Editar'),
    );
  }
}