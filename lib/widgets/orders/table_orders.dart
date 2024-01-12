import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/formatters/number_formatter_app.dart';
import 'package:flutter_app_erp/core/response/orders/orders_response.dart';
import 'package:flutter_app_erp/widgets/data_table_paginated.dart';
import 'package:flutter_app_erp/core/formatters/date_formatter_app.dart';
import 'package:flutter_app_erp/widgets/orders/button_delete_orders.dart';
import 'package:flutter_app_erp/widgets/shoppingCart/button_shopping_cart.dart';
import 'package:flutter_app_erp/widgets/typography.dart';

class DataTableOrders extends StatefulWidget {
  final int numberPage;
  final Future? future;
  final void Function()? onBack;
  final List<OrdersResponse> list;
  final void Function()? onForwad;
  final void Function()? onAfterDelete;
  final Function(Map<String, String>)? onOrden;

  const DataTableOrders({
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
  State<DataTableOrders> createState() => _DataTableOrdersState();
}

class _DataTableOrdersState extends State<DataTableOrders> {
  int? sortColumnIndex = 0;
  bool sortAscending = false;

  onSort(int n, bool b) {
    final list = <String>[
      "id",
      "number",
      "customer_id",
      "subtotal",
      "tax_amount",
      "total",
      "currency_id",
      "user_id",
      "porducts_count",
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
        .map((order) => DataRow(cells: <DataCell>[
              DataCell(TypographyApp(
                text: NumberFormatterApp.filled(order.number),
                variant: "body",
              )),
              DataCell(TypographyApp(
                  text: "${order.customer!.name} ${order.customer!.lastName}"
                      .trim(),
                  variant: "body1")),
              DataCell(TypographyApp(
                text: NumberFormatterApp.format(order.subtotal),
                variant: "body",
              )),
              DataCell(TypographyApp(
                text: NumberFormatterApp.format(order.taxAmount),
                variant: "body",
              )),
              DataCell(TypographyApp(
                text: NumberFormatterApp.format(order.total),
                variant: "body",
              )),
              DataCell(TypographyApp(
                  text: "${order.currency!.code} (${order.currency!.symbol})"
                      .trim(),
                  variant: "body1")),
              DataCell(TypographyApp(
                text: "${order.user!.firstName} ${order.user!.lastName}",
                variant: "body1",
              )),
              DataCell(TypographyApp(
                text: NumberFormatterApp.amount(order.productsCount),
                variant: "body",
              )),
              DataCell(TypographyApp(
                  text: DateFormatterApp.dateTimeFormatter(order.createdAt),
                  variant: "body1")),
              DataCell(TypographyApp(
                  text: DateFormatterApp.dateTimeFormatter(order.updatedAt),
                  variant: "body1")),
              DataCell(
                Row(
                  children: [
                    buttonShoppingCart(
                      context: context,
                      currencyId: order.currencyId,
                      orderId: order.id,
                    ),
                    const SizedBox(
                      width: 8,
                      height: 8,
                    ),
                    DeleteButtonOrders(
                      orderId: order.id,
                      context: context,
                      onAfterDelete: widget.onAfterDelete,
                    ),
                  ],
                ),
              ),
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
              text: 'N°',
              variant: "subtitle2",
            ),
          ),
          onSort: onSort,
        ),
        DataColumn(
          label: const Expanded(
            child: TypographyApp(
              text: 'Cliente',
              variant: "subtitle2",
            ),
          ),
          onSort: onSort,
        ),
        DataColumn(
          label: const Expanded(
            child: TypographyApp(
              text: 'Subtotal',
              variant: "subtitle2",
            ),
          ),
          onSort: onSort,
        ),
        DataColumn(
          label: const Expanded(
            child: TypographyApp(
              text: 'Monto de impuesto',
              variant: "subtitle2",
            ),
          ),
          onSort: onSort,
        ),
        DataColumn(
          label: const Expanded(
            child: TypographyApp(
              text: 'Total',
              variant: "subtitle2",
            ),
          ),
          onSort: onSort,
        ),
        DataColumn(
          label: const Expanded(
            child: TypographyApp(text: 'Moneda', variant: "subtitle2"),
          ),
          onSort: onSort,
        ),
        DataColumn(
          label: const Expanded(
            child: TypographyApp(
              text: 'Usuario',
              variant: "subtitle2",
            ),
          ),
          onSort: onSort,
        ),
        DataColumn(
          label: const Expanded(
            child: TypographyApp(
              text: 'Cantidad de productos',
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
      rows: rows,
    );
  }
}
