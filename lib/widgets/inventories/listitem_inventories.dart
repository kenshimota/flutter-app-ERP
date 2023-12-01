import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/%20formatters/date_formatter_app.dart';
import 'package:flutter_app_erp/core/%20formatters/number_formatter_app.dart';
import 'package:flutter_app_erp/core/response/inventories/inventories_response.dart';
import 'package:flutter_app_erp/widgets/inventories/popup_menu_inventory.dart';
import 'package:flutter_app_erp/widgets/typography.dart';
import 'package:flutter_app_erp/widgets/list_tile_app.dart';
import 'package:flutter_app_erp/widgets/list_view_app.dart';

class ColumnCell extends StatelessWidget {
  final String subtitle;
  final String content;

  const ColumnCell({
    super.key,
    required this.subtitle,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: TypographyApp(
              text: subtitle,
              variant: "subtitle2",
            ),
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: OverflowBox(
              maxWidth: null,
              child: TypographyApp(
                text: content,
                variant: "body1",
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ListTileInventory extends StatelessWidget {
  final InventoryResponse inventory;
  final void Function()? onAfterChange;

  const ListTileInventory({
    super.key,
    required this.inventory,
    this.onAfterChange,
  });

  Widget buildContent(BuildContext context) {
    String productName =
        "(${inventory.product?.code}) ${inventory.product?.name}";

    return SizedBox(
      height: 100,
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: ColumnCell(
                          subtitle: "Producto:",
                          content: productName,
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: ColumnCell(
                          subtitle: "Deposito:",
                          content: inventory.warehouse!.name,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: ColumnCell(
                          subtitle: "Reservado:",
                          content:
                              NumberFormatterApp.amount(inventory.reserved),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: ColumnCell(
                          subtitle: "Existencia:",
                          content: NumberFormatterApp.amount(
                            inventory.stock,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: ColumnCell(
                          subtitle: "Creación:",
                          content: DateFormatterApp.dateTimeFormatter(
                            inventory.createdAt,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: ColumnCell(
                          subtitle: "Existencia:",
                          content: DateFormatterApp.dateTimeFormatter(
                            inventory.updatedAt,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: ColumnCell(
                          subtitle: "Observaciones: ",
                          content: inventory.observations ?? "",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String productName =
        "(${inventory.product?.code}) ${inventory.product?.name}";

    return ListTileApp(
      leading: const CircleAvatar(
        child: Icon(Icons.inventory),
      ),
      title: TypographyApp(
        text: productName,
        variant: "subtitle1",
      ),
      trailing: PopupMenuInventory(
        inventory: inventory,
        onAfterChange: onAfterChange,
      ),
      content: buildContent(context),
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
