import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/formatters/date_formatter_app.dart';
import 'package:flutter_app_erp/core/formatters/number_formatter_app.dart';
import 'package:flutter_app_erp/widgets/column_cell.dart';
import 'package:flutter_app_erp/widgets/orders/popup_menu_order.dart';
import 'package:flutter_app_erp/widgets/slice_column.dart';
import 'package:flutter_app_erp/widgets/typography.dart';
import 'package:flutter_app_erp/widgets/list_tile_app.dart';
import 'package:flutter_app_erp/widgets/list_view_app.dart';
import 'package:flutter_app_erp/core/response/orders/orders_response.dart';

class ListTileContentOrders extends StatelessWidget {
  final OrdersResponse order;

  const ListTileContentOrders({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 100,
        child: SliceColumn(
          children: [
            ColumnCell(
              subtitle: "Codigo:",
              content: NumberFormatterApp.filled(order.number),
            ),
            ColumnCell(subtitle: "Subtotal:", content: "${order.subtotal}"),
            ColumnCell(
                subtitle: "Nombre:",
                content: "${order.customer!.name} ${order.customer!.lastName}"),
            ColumnCell(
                subtitle: "Monto de impuesto:", content: "${order.taxAmount}"),
            ColumnCell(
              subtitle: "Total:",
              content: NumberFormatterApp.format(order.total),
            ),
            ColumnCell(
              subtitle: "Moneda",
              content: "${order.currency!.code} (${order.currency!.symbol})",
            ),
            ColumnCell(
                subtitle: "Usuario",
                content: "${order.user!.firstName} ${order.user!.lastName}"),
            ColumnCell(
              subtitle: "Cantidad de productos",
              content: NumberFormatterApp.amount(order.productsCount),
            ),
            ColumnCell(
              subtitle: "Fecha de creacion",
              content: DateFormatterApp.dateTimeFormatter(order.createdAt),
            ),
            ColumnCell(
              subtitle: "Fecha de actualizacion",
              content: DateFormatterApp.dateTimeFormatter(order.updatedAt),
            ),
          ],
        ));
  }
}

class ListTileOrder extends StatelessWidget {
  final OrdersResponse order;
  final void Function()? onAfterChange;

  const ListTileOrder({super.key, required this.order, this.onAfterChange});

  @override
  Widget build(BuildContext context) {
    return ListTileApp(
      leading: const CircleAvatar(
        child: Icon(Icons.production_quantity_limits),
      ),
      title: TypographyApp(text: order.number.toString(), variant: "subtitle1"),
      subtitle: TypographyApp(text: order.customer!.name, variant: "body1"),
      trailing: PopupMenuOrder(
        order: order,
        onAfterChange: onAfterChange,
      ),
      heightContent: 150,
      content: ListTileContentOrders(
        order: order,
      ),
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
        ListTileOrder(order: order, onAfterChange: onAfterChange),
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
