import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/circular_button.dart';
import 'package:flutter_app_erp/widgets/dialog_new_currencie.dart';


class ButtonNewCurrencie extends StatelessWidget {
  final void Function()? onSave;
  const ButtonNewCurrencie({
    super.key,
    this.onSave,
  });

  onNewCurrencie(BuildContext context) {
    showDialog(context: context,
      builder: (BuildContext context) => AlertDialogNewCurrencie(
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
      onPressed: () => onNewCurrencie(context),
    );
  }
}