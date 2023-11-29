import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/%20formatters/number_formatter_app.dart';
import 'package:flutter_app_erp/core/response/inventories/inventories_response.dart';
import 'package:flutter_app_erp/widgets/inventories/popup_menu_inventory.dart';
import 'package:flutter_app_erp/widgets/typography.dart';
import 'package:flutter_app_erp/widgets/list_tile_app.dart';
import 'package:flutter_app_erp/widgets/list_view_app.dart';

class ListTileInventory extends StatelessWidget {
  final InventoryResponse inventory;
  final void Function()? onAfterChange;

  const ListTileInventory({
    super.key,
    required this.inventory,
    this.onAfterChange,
  });

  @override
  Widget build(BuildContext context) {
    return ListTileApp(
      leading: const CircleAvatar(
        child: Icon(Icons.inventory),
      ),
      title: TypographyApp(
        text: "(${inventory.product?.code}) ${inventory.product?.name}",
        variant: "subtitle1",
      ),
      trailing: PopupMenuInventory(
        inventory: inventory,
        onAfterChange: onAfterChange,
      ),
      subtitle: Row(
        children: [
          TypographyApp(
            text: inventory.warehouse?.name,
            variant: "body1",
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const TypographyApp(
                      text: "Disponible",
                      variant: "subtitle3",
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    TypographyApp(
                      text: NumberFormatterApp.amount(
                        inventory.stock - inventory.reserved,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ListTileInventories extends StatelessWidget {
  final int page;
  final Future? future;
  final void Function()? onForward;
  final List<InventoryResponse> inventories;
  final void Function()? onAfterChange;

  const ListTileInventories({
    super.key,
    required this.inventories,
    this.onAfterChange,
    this.onForward,
    this.page = 1,
    this.future,
  });

  Widget buildItem(BuildContext context, InventoryResponse inventory) {
    return Column(
      children: [
        ListTileInventory(inventory: inventory, onAfterChange: onAfterChange),
        const Divider(height: 1)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListViewApp(
      page: page,
      future: future,
      onNext: onForward,
      listItems: inventories,
      buildItems: (context, tax) => buildItem(context, tax),
    );
  }
}
