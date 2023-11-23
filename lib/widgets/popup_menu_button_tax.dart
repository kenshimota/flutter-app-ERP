import 'package:flutter/material.dart';

import 'package:flutter_app_erp/widgets/button_delete.dart';
import 'package:flutter_app_erp/core/response/taxes/taxes_response.dart';
import 'package:flutter_app_erp/widgets/dialog_edit_tax.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class PopupMenuApp extends StatelessWidget {
  final void Function()? onAfterChange;
  final TaxesResponse tax;
  const PopupMenuApp({super.key, this.onAfterChange, required this.tax});

  @override
  Widget build(BuildContext context) {
    return PopupMenuTax(onAfterChange: onAfterChange, tax: tax);
  }
}

class PopupMenuTax extends StatefulWidget {
  final void Function()? onAfterChange;
  final TaxesResponse tax;

  const PopupMenuTax({super.key, this.onAfterChange, required this.tax});

  @override
  State<PopupMenuTax> createState() => _PopupMenuTaxState();
}

class _PopupMenuTaxState extends State<PopupMenuTax> {
  SampleItem? selectedMenu;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SampleItem>(
      initialValue: selectedMenu,

      // Callback that sets the selected popup menu item.
      onSelected: (SampleItem item) {
        Widget Function(BuildContext)? builder;

        setState(() {
          selectedMenu = item;
        });

        if (item == SampleItem.itemOne) {
          builder = (context) => AlertDialogEditTax(
                tax: widget.tax,
                onSave: widget.onAfterChange,
              );
        } else if (item == SampleItem.itemTwo) {
          builder = (context) => AlertDialogDelete(
                taxId: widget.tax.id,
                onAfterDelete: widget.onAfterChange,
              );
        }

        if (builder != null) {
          showDialog(context: context, builder: builder);
        }
      },

      itemBuilder: (
        BuildContext context,
      ) =>
          <PopupMenuEntry<SampleItem>>[
        const PopupMenuItem<SampleItem>(
          value: SampleItem.itemOne,
          child: Text(
            'Editar',
            style: TextStyle(color: Colors.white),
          ),
        ),
        const PopupMenuItem<SampleItem>(
          value: SampleItem.itemTwo,
          child: Text(
            'Eliminar',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
