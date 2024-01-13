import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/http/ordens_items/get_all_orders_items.dart';
import 'package:flutter_app_erp/core/http/orders/get_order.dart';
import 'package:flutter_app_erp/core/response/orders/orders_response.dart';
import 'package:flutter_app_erp/core/response/orders_items/orders_items_response.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:flutter_app_erp/widgets/orders/button_delete_orders.dart';
import 'package:flutter_app_erp/widgets/shoppingCart/alert_dialog_products_prices.dart';
import 'package:flutter_app_erp/widgets/shoppingCart/print_invoice_from_order.dart';
import 'package:flutter_app_erp/widgets/typography.dart';
import 'package:provider/provider.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class PopupMenuOrder extends StatelessWidget {
  final OrdersResponse order;
  final void Function()? onAfterChange;

  const PopupMenuOrder({
    super.key,
    this.onAfterChange,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return PopupOrder(
      onAfterChange: onAfterChange,
      order: order,
    );
  }
}

class PopupOrder extends StatefulWidget {
  final void Function()? onAfterChange;
  final OrdersResponse order;

  const PopupOrder({
    super.key,
    this.onAfterChange,
    required this.order,
  });

  @override
  State<PopupOrder> createState() => _PopupOrderState();
}

class _PopupOrderState extends State<PopupOrder> {
  Color? color;
  SampleItem? selectedMenu;

  Future<void> onRequestApi(String token, int orderId) async {
    final OrdersResponse order = await getOrder(token: token, orderId: orderId);
    final List<OrdersItemsResponse> articles =
        await getAllOrdersItems(token: token, orderId: orderId);

    await printInvoiceFromOrder(order: order, articles: articles);
  }

  onSelect(SampleItem item, String token) {
    Widget Function(BuildContext)? builder;

    setState(() {
      selectedMenu = item;
    });

    if (item == SampleItem.itemOne) {
      builder = (context) => AlertDialogDelete(
            orderId: widget.order.id,
            onAfterDelete: widget.onAfterChange,
          );
    }

    if (item == SampleItem.itemTwo) {
      builder = (context) => AlertDialogProductsPrices(
            orderId: widget.order.id,
            currencyId: widget.order.currencyId,
            onSave: widget.onAfterChange,
          );
    }

    if (item == SampleItem.itemThree) {
      onRequestApi(token, widget.order.id);
    }

    if (builder != null) {
      showDialog(context: context, builder: builder);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final List<PopupMenuEntry<SampleItem>> children = [];
    final String token = authProvider.getToken() as String;

    if (widget.order.orderStatusId == 1) {
      children.add(
        const PopupMenuItem<SampleItem>(
          value: SampleItem.itemTwo,
          child: TypographyApp(
            text: 'Editar',
            variant: "subtitle2",
            color: "white",
          ),
        ),
      );

      children.add(const PopupMenuItem<SampleItem>(
        value: SampleItem.itemOne,
        child: TypographyApp(
          text: 'Eliminar',
          variant: "subtitle2",
          color: "white",
        ),
      ));
    }

    if (widget.order.orderStatusId == 2) {
      children.add(const PopupMenuItem<SampleItem>(
        value: SampleItem.itemThree,
        child: TypographyApp(
          text: 'Imprimir',
          variant: "subtitle2",
          color: "white",
        ),
      ));
    }

    return PopupMenuButton<SampleItem>(
      initialValue: selectedMenu,
      onSelected: (item) => onSelect(item, token),
      itemBuilder: (BuildContext context) => children,
    );
  }
}
