import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/typography.dart';
import 'package:flutter_app_erp/widgets/form_currencie_update.dart';
import 'package:flutter_app_erp/core/response/currencies/currencies_response.dart';

class AlertDialgEditCurrencie extends StatefulWidget {
  final CurrenciesResponse currencie;
  final void Function()? onSave;

  const AlertDialgEditCurrencie({
    super.key,
    this.onSave,
    required this.currencie,
  });

  @override
  _AlertDialogEditCurrencie createState() => _AlertDialogEditCurrencie();
}

class _AlertDialogEditCurrencie extends State<AlertDialgEditCurrencie> {
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
          text: 'Editar Moneda',
          variant: "h2",
        ),
        actions: [
          FormCurrencieUpdate(
            currencie: widget.currencie,
            onAfterSave: () => onAfterSave(context),
          ),
        ]);
  }
}

