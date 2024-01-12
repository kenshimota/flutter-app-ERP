import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/%20formatters/date_formatter_app.dart';
import 'package:flutter_app_erp/core/%20formatters/number_formatter_app.dart';
import 'package:flutter_app_erp/core/response/products_prices/products_prices_response.dart';
import 'package:flutter_app_erp/widgets/data_table_paginated.dart';
import 'package:flutter_app_erp/widgets/products_prices/button_delete_product_price.dart';
import 'package:flutter_app_erp/widgets/products_prices/button_edit_product_price.dart';
import 'package:flutter_app_erp/widgets/typography.dart';

class TableProductsPrices extends StatefulWidget {
    final int numberPage;
  final Future? future;
  final void Function()? onBack;
  final List<ProductsPricesResponse> list;
  final void Function()? onForwad;
  final void Function()? onAfterDelete;
  final Function(Map<String, String>)? onOrden;
  const TableProductsPrices({
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
  State<TableProductsPrices> createState() => _TableProductsPrices();
}

class _TableProductsPrices extends State<TableProductsPrices>{
   int? sortColumnIndex = 0;
  bool sortAscending = false;

  onSort(int n, bool b) {
    final list = <String>[
      "currency_id",
      "product_id",
      "price",
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
  Widget build(BuildContext context){
    final List<DataRow> rows = widget.list
    .map((productPrice) => DataRow(cells: <DataCell>[
     DataCell(TypographyApp(
      text: "${productPrice.currency!.code} (${productPrice.currency!.symbol})"
        .trim(),
      variant: "body1"
    )),
    DataCell(TypographyApp(
      text: "${productPrice.product!.code} (${productPrice.product!.name})",
      variant: "body1",
    )),
    DataCell(TypographyApp(
      text: NumberFormatterApp.format(productPrice.price), 
      variant: "body1",
    )),
    DataCell(TypographyApp(
      text: DateFormatterApp.dateTimeFormatter(productPrice.createdAt), 
      variant: "body1",
    )),
    DataCell(TypographyApp(
      text: DateFormatterApp.dateTimeFormatter(productPrice.updatedAt), 
      variant: "body1",
    )),
    DataCell(
      Row(
        children: [
          ButtonEditProductPrice(
            productPrice: productPrice,
            onSave: widget.onAfterDelete,
          ),
          const SizedBox(
            width: 8,
            height: 8,
          ),
          ButtonDeleteProductPrice(
            productPriceId: productPrice.id,
            context: context,
            onAfterDelete: widget.onAfterDelete,
          ),
          
        ],
      ),
    ),
    ])).toList();

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
              text: 'Moneda',
              variant: "subtitle2",
            ),
          ),
          onSort: onSort,
        ),
        DataColumn(
          label: const Expanded(
            child: TypographyApp(
              text: 'Producto',
              variant: "subtitle2",
            ),
          ),
          onSort: onSort,
        ),
        DataColumn(
          label: const Expanded(
            child: TypographyApp(
              text: 'Precio',
              variant: "subtitle2",
            ),
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
      rows: rows
    );
  }
}