import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/inventories/dialog_edit_inventory.dart';
import 'package:flutter_app_erp/core/response/inventories/inventories_response.dart';

class ButtonEditInventory extends StatelessWidget {
  final void Function()? onSave;
  final InventoryResponse inventory;

  const ButtonEditInventory({
    super.key,
    this.onSave,
    required this.inventory,
  });

  onEditInventory(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialogEditInventory(
        inventory: inventory,
        onSave: onSave,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onEditInventory(context),
      icon: const Icon(Icons.edit),
    );
  }
}

class TextButtonEditInventory extends StatelessWidget {
  final Color? color;
  final void Function()? onSave;
  final InventoryResponse inventory;

  const TextButtonEditInventory({
    super.key,
    this.onSave,
    this.color,
    required this.inventory,
  });

  onEditInventory(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialogEditInventory(
        inventory: inventory,
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
      onPressed: () => onEditInventory(context),
      child: const Text('Editar'),
    );
  }
}
