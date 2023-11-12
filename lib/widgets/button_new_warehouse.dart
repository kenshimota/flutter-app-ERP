import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/circular_button.dart';
import 'package:flutter_app_erp/widgets/dialog_new_warehouse.dart';

class ButtonNewWarehouse extends StatelessWidget {
  final void Function()? onSave;
  const ButtonNewWarehouse({
    super.key,
    this.onSave,
  });

  onNewWarehouse(BuildContext context) {
    showDialog(context: context,
      builder: (BuildContext context) => AlertDialogNewWarehouse(
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
      onPressed: () => onNewWarehouse(context),
    );
  }
}