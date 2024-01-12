import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/products/button_delete_product.dart';
import 'package:flutter_app_erp/widgets/products/button_edit_product.dart';
import 'package:flutter_app_erp/widgets/typography.dart';
import 'package:flutter_app_erp/widgets/data_table_paginated.dart';
import 'package:flutter_app_erp/core/formatters/date_formatter_app.dart';
import 'package:flutter_app_erp/core/formatters/number_formatter_app.dart';
import 'package:flutter_app_erp/core/response/products/products_response.dart';

class DataTableProducts extends StatefulWidget {
  final int numberPage;
  final Future? future;
  final void Function()? onBack;
  final List<ProductsResponse> list;
  final void Function()? onForwad;
  final void Function()? onAfterDelete;
  final Function(Map<String, String>)? onOrden;

  const DataTableProducts({
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
  State<DataTableProducts> createState() => _DataTableProducts();
}

class _DataTableProducts extends State<DataTableProducts> {
  int? sortColumnIndex;
  bool sortAscending = true;

  onSort(int n, bool b) {
    final list = <String>[
      "code",
      "name",
      "bar_code",
      "stock",
      "reserve",
      "tax_id",
      "created_at",
      "updated_at"
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
          (product) => DataRow(
            cells: <DataCell>[
              DataCell(TypographyApp(text: product.code, variant: "body1")),
              DataCell(TypographyApp(text: product.name, variant: "body1")),
              DataCell(
                  TypographyApp(text: product.barCode ?? "", variant: "body1")),
              DataCell(
                TypographyApp(
                  text: NumberFormatterApp.amount(product.stock) ?? "",
                  variant: "body1",
                ),
              ),
              DataCell(TypographyApp(
                  variant: "body1",
                  text: NumberFormatterApp.amount(product.reserved) ?? "")),
              DataCell(
                  TypographyApp(variant: "body1", text: product.tax!.name)),
              DataCell(TypographyApp(
                variant: "body1",
                text: DateFormatterApp.dateTimeFormatter(product.createdAt),
              )),
              DataCell(TypographyApp(
                variant: "body1",
                text: DateFormatterApp.dateTimeFormatter(product.updatedAt),
              )),
              DataCell(Row(
                children: [
                  ButtonEditProduct(
                    product: product,
                    onSave: widget.onAfterDelete,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ButtonDeleteProduct(
                    context: context,
                    productId: product.id,
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
            child: TypographyApp(text: 'Codigo', variant: "subtitle2"),
          ),
          onSort: onSort,
        ),
        DataColumn(
          label: const Expanded(
            child: TypographyApp(text: 'Nombre', variant: "subtitle2"),
          ),
          onSort: onSort,
        ),
        DataColumn(
          label: const Expanded(
            child: TypographyApp(text: 'Codigo de Barra', variant: "subtitle2"),
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
            child: TypographyApp(text: 'Reserva', variant: "subtitle2"),
          ),
          onSort: onSort,
        ),
        DataColumn(
          label: const Expanded(
            child: TypographyApp(text: 'Impuesto', variant: "subtitle2"),
          ),
          onSort: onSort,
        ),
        DataColumn(
          label: const Expanded(
            child:
                TypographyApp(text: 'Fecha de creación', variant: "subtitle2"),
          ),
          onSort: onSort,
        ),
        DataColumn(
          label: const Expanded(
            child: TypographyApp(
                text: 'Fecha de actualizacion', variant: "subtitle2"),
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
