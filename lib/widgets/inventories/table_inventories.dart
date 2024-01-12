import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/response/inventories/inventories_response.dart';
import 'package:flutter_app_erp/widgets/inventories/button_delete_inventory.dart';
import 'package:flutter_app_erp/widgets/inventories/button_edit_inventory.dart';
import 'package:flutter_app_erp/widgets/typography.dart';
import 'package:flutter_app_erp/widgets/data_table_paginated.dart';
import 'package:flutter_app_erp/core/formatters/date_formatter_app.dart';
import 'package:flutter_app_erp/core/formatters/number_formatter_app.dart';

class DataTableInventories extends StatefulWidget {
  final int numberPage;
  final Future? future;
  final void Function()? onBack;
  final List<InventoryResponse> list;
  final void Function()? onForwad;
  final void Function()? onAfterDelete;
  final Function(Map<String, String>)? onOrden;

  const DataTableInventories({
    super.key,
    required this.list,
    required this.onOrden,
    this.onAfterDelete,
    this.onBack,
    this.onForwad,
    this.future,
    this.numberPage = 1,
  });

  @override
  State<DataTableInventories> createState() => _DataTableInventories();
}

class _DataTableInventories extends State<DataTableInventories> {
  int? sortColumnIndex;
  bool sortAscending = true;

  onSort(int n, bool b) {
    final list = <String>[
      "product_id",
      "warehouse_id",
      "stock",
      "reserved",
      "created_at",
      "updated_at",
      "observations"
    ];

    setState(() {
      sortColumnIndex = n;
      sortAscending = b;
    });

    String type = b ? "asc" : "desc";
    widget.onOrden!({'field': list[n], 'type': type});
  }

  @override
  Widget build(BuildContext context) {
    final List<DataRow> rows = widget.list
        .map(
          (inventory) => DataRow(
            cells: <DataCell>[
              DataCell(
                TypographyApp(
                  text: inventory.product?.name,
                  variant: "body1",
                ),
              ),
              DataCell(
                TypographyApp(
                  text: inventory.warehouse?.name,
                  variant: "body1",
                ),
              ),
              DataCell(
                TypographyApp(
                    text: NumberFormatterApp.amount(inventory.stock),
                    variant: "body1"),
              ),
              DataCell(
                TypographyApp(
                  text: NumberFormatterApp.amount(inventory.reserved),
                  variant: "body1",
                ),
              ),
              DataCell(TypographyApp(
                variant: "body1",
                text: DateFormatterApp.dateTimeFormatter(inventory.createdAt),
              )),
              DataCell(TypographyApp(
                variant: "body1",
                text: DateFormatterApp.dateTimeFormatter(inventory.updatedAt),
              )),
              DataCell(
                TypographyApp(
                  variant: "body1",
                  text: inventory.observations ?? "",
                ),
              ),
              DataCell(Row(
                children: [
                  ButtonEditInventory(
                    inventory: inventory,
                    onSave: widget.onAfterDelete,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ButtonDeleteInventory(
                    inventoryId: inventory.id,
                    context: context,
                    onAfterDelete: widget.onAfterDelete,
                  ),
                ],
              )),
            ],
          ),
        )
        .toList();

    return DataTablePaginated(
      future: widget.future,
      onBack: widget.onBack,
      onForwad: widget.onForwad,
      numberPage: widget.numberPage,
      columnSpacing: 16,
      horizontalMargin: 16,
      sortColumnIndex: sortColumnIndex,
      sortAscending: sortAscending,
      columns: [
        DataColumn(
          label: const Expanded(
            child: TypographyApp(text: 'Producto', variant: "subtitle2"),
          ),
          onSort: onSort,
        ),
        DataColumn(
          label: const Expanded(
            child: TypographyApp(text: 'Deposito', variant: "subtitle2"),
          ),
          onSort: onSort,
        ),
        DataColumn(
          label: const Expanded(
            child: TypographyApp(text: 'Existencia', variant: "subtitle2"),
          ),
          onSort: onSort,
        ),
        DataColumn(
          label: const Expanded(
            child: TypographyApp(text: 'Reservado', variant: "subtitle2"),
          ),
          onSort: onSort,
        ),
        DataColumn(
          label: const Expanded(
            child: TypographyApp(text: 'Creación', variant: "subtitle2"),
          ),
          onSort: onSort,
        ),
        DataColumn(
          label: const Expanded(
            child: TypographyApp(text: 'Actualización', variant: "subtitle2"),
          ),
          onSort: onSort,
        ),
        DataColumn(
          label: const Expanded(
            child: TypographyApp(text: 'Observaciones', variant: "subtitle2"),
          ),
          onSort: onSort,
        ),
        const DataColumn(
          label: Expanded(
            child: TypographyApp(text: 'Acciones', variant: "subtitle2"),
          ),
        ),
      ],
      rows: rows,
    );
  }
}
