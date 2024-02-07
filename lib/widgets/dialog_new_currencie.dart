import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/alert_dialog_app.dart';
import 'package:flutter_app_erp/widgets/typography.dart';
import 'package:flutter_app_erp/widgets/form_currencie_create.dart';

class AlertDialogNewCurrencie extends StatefulWidget {
  final void Function()? onSave;

  const AlertDialogNewCurrencie({
    super.key,
    this.onSave,
  });

  @override
  // ignore: library_private_types_in_public_api
  _AlertDialogNewCurrencie createState() => _AlertDialogNewCurrencie();
}

class _AlertDialogNewCurrencie extends State<AlertDialogNewCurrencie> {
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
      maxHeight: 430,
      title: const TypographyApp(
        text: 'Nueva Moneda',
        variant: "h3",
      ),
      content: [
        Expanded(
          child: FormCurrencieCreate(
            onAfterSave: () => onAfterSave(context),
          ),
        ),
      ],
    );
  }
}
