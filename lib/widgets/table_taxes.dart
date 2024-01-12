import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/response/taxes/taxes_response.dart';
import 'package:flutter_app_erp/widgets/button_delete.dart';
import 'package:flutter_app_erp/widgets/button_edit_tax.dart';
import 'package:flutter_app_erp/widgets/data_table_paginated.dart';
import 'package:flutter_app_erp/core/formatters/date_formatter_app.dart';
import 'package:flutter_app_erp/core/formatters/number_formatter_app.dart';
import 'package:flutter_app_erp/widgets/typography.dart';

class DataTableTaxes extends StatefulWidget {
  final int numberPage;
  final Future? future;
  final void Function()? onBack;
  final List<TaxesResponse> list;
  final void Function()? onForwad;
  final void Function()? onAfterDelete;
  final Function(Map<String, String>)? onOrden;

  const DataTableTaxes({
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
  State<DataTableTaxes> createState() => _DataTableTaxesState();
}

class _DataTableTaxesState extends State<DataTableTaxes> {
  int? sortColumnIndex;
  bool sortAscending = true;

  onSort(int n, bool b) {
    final list = <String>["name", "percentage", "created_at", "updated_at"];

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
          (tax) => DataRow(
            cells: <DataCell>[
              DataCell(TypographyApp(text: tax.name, variant: "body1")),
              DataCell(TypographyApp(
                text: NumberFormatterApp.percentageFormat(tax.percentage),
                variant: "body1",
              )),
              DataCell(TypographyApp(
                variant: "body1",
                text: DateFormatterApp.dateTimeFormatter(tax.createdAt),
              )),
              DataCell(TypographyApp(
                variant: "body1",
                text: DateFormatterApp.dateTimeFormatter(tax.updatedAt),
              )),
              DataCell(Row(
                children: [
                  ButtonEditTax(
                    tax: tax,
                    onSave: widget.onAfterDelete,
                  ),
                  const SizedBox(
                    width: 8,
                    height: 8,
                  ),
                  DeleteButtonTaxes(
                    taxId: tax.id,
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
      columnSpacing: 16, // Espacio entre columnas
      horizontalMargin: 16,
      sortColumnIndex: sortColumnIndex,
      sortAscending: sortAscending,
      columns: [
        DataColumn(
          label: const Expanded(
            child: TypographyApp(
              text: 'Nombre',
              variant: "subtitle2",
            ),
          ),
          onSort: onSort,
        ),
        DataColumn(
          label: const Expanded(
            child: TypographyApp(text: 'Impuestos', variant: "subtitle2"),
          ),
          onSort: onSort,
        ),
        DataColumn(
          label: const Expanded(
            child: TypographyApp(
              variant: "subtitle2",
              text: 'Fecha de Creación',
            ),
          ),
          onSort: onSort,
        ),
        DataColumn(
          label: const Expanded(
            child: TypographyApp(
              variant: "subtitle2",
              text: 'Fecha de actualizacion',
            ),
          ),
          onSort: onSort,
        ),
        const DataColumn(
          label: Expanded(
            child: TypographyApp(
              variant: "subtitle2",
              text: 'Acciones',
            ),
          ),
        ),
      ],
      rows: rows,
    );
  }
}
