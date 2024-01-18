import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/formatters/date_formatter_app.dart';
import 'package:flutter_app_erp/core/formatters/number_formatter_app.dart';
import 'package:flutter_app_erp/widgets/column_cell.dart';
import 'package:flutter_app_erp/widgets/orders/popup_menu_order.dart';
import 'package:flutter_app_erp/widgets/shoppingCart/print_invoice_from_order.dart';
import 'package:flutter_app_erp/widgets/slice_column.dart';
import 'package:flutter_app_erp/widgets/typography.dart';
import 'package:flutter_app_erp/widgets/list_tile_app.dart';
import 'package:flutter_app_erp/widgets/list_view_app.dart';
import 'package:flutter_app_erp/core/response/orders/orders_response.dart';

class ListTileContentOrders extends StatelessWidget {
  final OrdersResponse order;
  final void Function()? onAfterChange;

  const ListTileContentOrders({
    super.key,
    required this.order,
    this.onAfterChange,
  });

  Widget buildContent(BuildContext context) {
    return SizedBox(
        height: 100,
        child: SliceColumn(
          children: [
            ColumnCell(
              subtitle: "N°:",
              content: NumberFormatterApp.filled(order.number),
            ),
            ColumnCell(subtitle: "Subtotal:", content: NumberFormatterApp.format(order.subtotal)),
            ColumnCell(
                subtitle: "Cliente:",
                content: "${order.customer!.name} ${order.customer!.lastName}"),
            ColumnCell(
                subtitle: "Impuesto:", content: "${order.taxAmount}"),
            ColumnCell(
              subtitle: "Total:",
              content: NumberFormatterApp.format(order.total),
            ),
            ColumnCell(
              subtitle: "Moneda:",
              content: "${order.currency!.code} (${order.currency!.symbol})",
            ),
            ColumnCell(
                subtitle: "Usuario:",
                content: "${order.user!.firstName} ${order.user!.lastName}"),
            ColumnCell(
              subtitle: "Cantidad de productos:",
              content: NumberFormatterApp.amount(order.productsCount),
            ),
            ColumnCell(
              subtitle: "Creación:",
              content: DateFormatterApp.dateTimeFormatter(order.createdAt),
            ),
            ColumnCell(
              subtitle: "Actualización:",
              content: DateFormatterApp.dateTimeFormatter(order.updatedAt),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return ListTileApp(
      leading: const CircleAvatar(
        child: Icon(Icons.production_quantity_limits),
      ),
      title: TypographyApp(
          text: NumberFormatterApp.filled(order.number), 
          variant: "subtitle1"
      ),
      trailing: PopupMenuOrder(
        order: order,
        onAfterChange: onAfterChange,
      ),
      /*subtitle: */

      heightContent: 150,
      content: buildContent(context),
      subtitle: Row(children: [
        TypographyApp(
            text: "${order.customer!.name} ${order.customer!.lastName}",
            variant: "body1"),
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const TypographyApp(
                    text: "total",
                    variant: "subtitle3",
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  TypographyApp(
                    text: "${NumberFormatterApp.format(order.total)} ${order.currency!.symbol}"),
                ],
              )
            ],
          ),
        ),
      ]),
      /*content: ListTileContentOrders(
        order: order,
      ), */
    );
  }
}

class ListTileOrders extends StatelessWidget {
  final int page;
  final Future? future;
  final void Function()? onForward;
  final List<OrdersResponse> orders;
  final void Function()? onAfterChange;

  const ListTileOrders({
    super.key,
    required this.orders,
    this.onAfterChange,
    this.onForward,
    this.page = 1,
    this.future,
  });

  Widget buildItem(BuildContext context, OrdersResponse order) {
    return Column(
      children: [
        ListTileContentOrders(order: order, onAfterChange: onAfterChange),
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
      listItems: orders,
      buildItems: (context, tax) => buildItem(context, tax),
    );
  }
}
