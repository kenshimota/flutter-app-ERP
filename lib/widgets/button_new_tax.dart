import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/circular_button.dart';
import 'package:flutter_app_erp/widgets/dialog_new_tax.dart';

class ButtonNewTax extends StatelessWidget {
  final void Function()? onSave;

  const ButtonNewTax({
    super.key,
    this.onSave,
  });

  onNewTax(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialogNewTax(
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
      onPressed: () => onNewTax(context),
    );
  }
}
