import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/typography.dart';
import 'package:flutter_app_erp/widgets/form_warehouse_create.dart';

class AlertDialogNewWarehouse extends StatefulWidget{
  final void Function()? onSave;

  const AlertDialogNewWarehouse({
    super.key,
    this.onSave,
  });

  @override
  // ignore: library_private_types_in_public_api
  _AlertDialogNewWarehouse createState() => _AlertDialogNewWarehouse();
}

class _AlertDialogNewWarehouse extends State<AlertDialogNewWarehouse>{
  void onAfterSave(context) {
    if(context.mounted == false){
      return;
    }

    Navigator.pop(context);
    widget.onSave!();
  }

  @override
  Widget build(BuildContext context){
    return AlertDialog(
      title: const TypographyApp(
        text: 'Nuevo deposito',
        variant: "h3",
      ),
      actions: [
        FormWarehouseCreate(
            onAfterSave: () => onAfterSave(context),
          ),
      ],
    );
  }
}