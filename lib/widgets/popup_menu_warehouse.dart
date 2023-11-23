import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/response/warehouse/warehouse_response.dart';

import 'package:flutter_app_erp/widgets/button_delete_warehouse.dart';

import 'package:flutter_app_erp/widgets/dialog_edit_warehouse.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class PopupMenuWarehouse extends StatelessWidget {
  final void Function()? onAfterChange;
  final WarehouseResponse ware;

  const PopupMenuWarehouse({super.key, this.onAfterChange, required this.ware});

  @override
  Widget build(BuildContext context) {
    return PopupWare(onAfterChange: onAfterChange, ware: ware);
  }
}

class PopupWare extends StatefulWidget {
  final void Function()? onAfterChange;
  final WarehouseResponse ware;

  const PopupWare({super.key, this.onAfterChange, required this.ware});

  @override
  State<PopupWare> createState() => _PopupWareState();
}

class _PopupWareState extends State<PopupWare> {
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
          builder = (context) => AlertDialogEditWarehouse(
                ware: widget.ware,
                onSave: widget.onAfterChange,
              );
        } else if (item == SampleItem.itemTwo) {
          builder = (context) => AlertDialogDelete(
                wareId: widget.ware.id,
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
