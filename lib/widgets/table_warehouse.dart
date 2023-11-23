import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/response/warehouse/warehouse_response.dart';
import 'package:flutter_app_erp/widgets/button_edit_warehouse.dart';
import 'package:flutter_app_erp/widgets/data_table_paginated.dart';
import 'package:flutter_app_erp/widgets/button_delete_warehouse.dart';
import 'package:flutter_app_erp/core/ formatters/date_formatter_app.dart';
import 'package:flutter_app_erp/widgets/typography.dart';

class DataTableWarehouse extends StatefulWidget {
  final int numberPage;
  final List<WarehouseResponse> list;
  final void Function()? onForwad;
  final void Function()? onBack;
  final Future? future;
  final Function(Map<String, String>)? onOrden;
  final void Function()? onAfterDelete;
  const DataTableWarehouse({
    super.key,
    required this.list,
    required this.onOrden,
    this.onForwad,
    this.onBack,
    this.numberPage = 1,
    this.future,
    this.onAfterDelete,
  });

  @override
  State<DataTableWarehouse> createState() => _DataTableWarehouse();
}

class _DataTableWarehouse extends State<DataTableWarehouse> {
  int? sortColumnIndex;
  bool sortAscending = true;

  onSort(int n, bool b) {
    final list = <String>["name", "address", "created_at", "updated_at"];

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
        .map((ware) => DataRow(cells: <DataCell>[
              DataCell(TypographyApp(
                text: ware.name,
                variant: "body1",
              )),
              DataCell(TypographyApp(text: ware.address, variant: "body1")),
              DataCell(TypographyApp(
                text: DateFormatterApp.dateTimeFormatter(ware.createdAt),
              )),
              DataCell(TypographyApp(
                variant: "body1",
                text: DateFormatterApp.dateTimeFormatter(ware.updatedAt),
              )),
              DataCell(Row(
                children: [
                  ButtonEditWarehouse(
                    ware: ware,
                    onSave: widget.onAfterDelete,
                  ),
                  const SizedBox(
                    width: 8,
                    height: 8,
                  ),
                  ButtonDeleteWarehouse(
                    wareId: ware.id,
                    context: context,
                    onAfterDelete: widget.onAfterDelete,
                  )
                ],
              )),
            ]))
        .toList();

    return DataTablePaginated(
        future: widget.future,
        onBack: widget.onBack,
        onForwad: widget.onForwad,
        numberPage: widget.numberPage,
        columnSpacing: 16, // Espacio entre columnas
        horizontalMargin: 16,
        sortColumnIndex: sortColumnIndex,
        sortAscending: sortAscending,
        columns: [
          DataColumn(
            label: const Expanded(
              child: TypographyApp(
                variant: "subtitle2",
                text: 'Nombre',
              ),
            ),
            onSort: onSort,
          ),
          DataColumn(
              label: const Expanded(
                child: TypographyApp(
                  variant: "subtitle2",
                  text: 'Direccion',
                ),
              ),
              onSort: onSort),
          DataColumn(
              label: const Expanded(
                child: TypographyApp(
                  variant: "subtitle2",
                  text: 'Fecha de creado',
                ),
              ),
              onSort: onSort),
          DataColumn(
              label: const Expanded(
                child: TypographyApp(
                  variant: "subtitle2",
                  text: 'Fecha de actualizado',
                ),
              ),
              onSort: onSort),
          const DataColumn(
            label: Expanded(
              child: TypographyApp(
                variant: "subtitle2",
                text: 'Acciones',
              ),
            ),
          ),
        ],
        rows: rows);
  }
}
