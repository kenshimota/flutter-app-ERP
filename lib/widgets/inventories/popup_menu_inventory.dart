import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/response/inventories/inventories_response.dart';
import 'package:flutter_app_erp/widgets/inventories/button_delete_inventory.dart';
import 'package:flutter_app_erp/widgets/inventories/dialog_edit_inventory.dart';
import 'package:flutter_app_erp/widgets/typography.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class PopupMenuInventory extends StatelessWidget {
  final InventoryResponse inventory;
  final void Function()? onAfterChange;

  const PopupMenuInventory({
    super.key,
    this.onAfterChange,
    required this.inventory,
  });

  @override
  Widget build(BuildContext context) {
    return PopupInventory(
      onAfterChange: onAfterChange,
      inventory: inventory,
    );
  }
}

class PopupInventory extends StatefulWidget {
  final InventoryResponse inventory;
  final void Function()? onAfterChange;

  const PopupInventory({
    super.key,
    this.onAfterChange,
    required this.inventory,
  });

  @override
  State<PopupInventory> createState() => _PopupInventoryState();
}

class _PopupInventoryState extends State<PopupInventory> {
  Color? color;
  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SampleItem>(
      initialValue: selectedMenu,
      onSelected: (SampleItem item) {
        Widget Function(BuildContext)? builder;
        setState(() {
          selectedMenu = item;
        });

        if (item == SampleItem.itemOne) {
          builder = (context) => AlertDialogEditInventory(
                inventory: widget.inventory,
                onSave: widget.onAfterChange,
              );
        } else if (item == SampleItem.itemTwo) {
          builder = (context) => AlertDialogDeleteInventory(
                inventoryId: widget.inventory.id,
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
          child: TypographyApp(
            text: 'Editar',
            variant: "subtitle2",
            color: "white",
          ),
        ),
        const PopupMenuItem<SampleItem>(
          value: SampleItem.itemTwo,
          child: TypographyApp(
            text: 'Eliminar',
            variant: "subtitle2",
            color: "white",
          ),
        ),
      ],
    );
  }
}
