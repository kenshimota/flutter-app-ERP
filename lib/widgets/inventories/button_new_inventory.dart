import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/circular_button.dart';
import 'package:flutter_app_erp/widgets/inventories/dialog_new_inventory.dart';

class ButtonNewInventory extends StatelessWidget {
  final void Function()? onSave;
  const ButtonNewInventory({
    super.key,
    this.onSave,
  });

  onNewInventory(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialogNewInventory(
        onSave: onSave,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CircularButton(
      icon: const Icon(
        Icons.add,
        color: Colors.white,
      ),
      context: context,
      onPressed: () => onNewInventory(context),
    );
  }
}
