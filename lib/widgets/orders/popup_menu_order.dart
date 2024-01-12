import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/response/orders/orders_response.dart';
import 'package:flutter_app_erp/widgets/orders/button_delete_orders.dart';
import 'package:flutter_app_erp/widgets/shoppingCart/alert_dialog_products_prices.dart';
import 'package:flutter_app_erp/widgets/typography.dart';

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

  onSelect(SampleItem item) {
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
          );
    }

    if (builder != null) {
      showDialog(context: context, builder: builder);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SampleItem>(
      initialValue: selectedMenu,
      onSelected: onSelect,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
        const PopupMenuItem<SampleItem>(
          value: SampleItem.itemTwo,
          child: TypographyApp(
            text: 'Editar',
            variant: "subtitle2",
            color: "white",
          ),
        ),
        const PopupMenuItem<SampleItem>(
          value: SampleItem.itemOne,
          child: TypographyApp(
            text: 'Eliminar',
            variant: "subtitle2",
            color: "white",
          ),
        ),
      ],
    );
  }
}
