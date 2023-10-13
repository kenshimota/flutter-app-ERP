import 'package:flutter/material.dart';

import 'package:flutter_app_erp/widgets/button_delete.dart';
import 'package:flutter_app_erp/widgets/button_edit_tax.dart';
import 'package:flutter_app_erp/core/response/taxes/taxes_response.dart';

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
        setState(() {
          selectedMenu = item;
        });
      },



      color: Colors.grey,
      itemBuilder: (BuildContext context,) => <PopupMenuEntry<SampleItem>>[
        
        PopupMenuItem<SampleItem>(
          value: SampleItem.itemOne,
          child:  TextButtonEditTax (
            color: Colors.white,
            tax: widget.tax,
            onSave: widget.onAfterChange,
          ),
        ),
        PopupMenuItem<SampleItem>(
          value: SampleItem.itemTwo,
          child: TextButtonDeleteTax(
            color: Colors.white,
            taxId: widget.tax.id,
            context: context,
            onAfterDelete: widget.onAfterChange,
          ),
        ),
      ],
    );
  }
}
