import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/formatters/number_formatter_app.dart';
import 'package:flutter_app_erp/core/response/orders_items/orders_items_response.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:flutter_app_erp/providers/cartProvider.dart';
import 'package:flutter_app_erp/widgets/list_tile_app.dart';
import 'package:flutter_app_erp/widgets/list_view_scrolling_infinite.dart';
import 'package:flutter_app_erp/widgets/typography.dart';
import 'package:provider/provider.dart';

class ListTileItem extends StatelessWidget {
  final OrdersItemsResponse item;
  final Function()? onAfterSave;

  const ListTileItem({super.key, required this.item, this.onAfterSave});

  Future<void> onDelete({required BuildContext context}) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final String token = authProvider.getToken() as String;

    try {
      await cartProvider.removeItem(itemId: item.id, token: token);
      onAfterSave!();
    } catch (e) {
      debugPrint("$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final String symbol = item.currency!.symbol;
    final quantityStr = NumberFormatterApp.amount(item.quantity);
    final amountStr = NumberFormatterApp.format(item.priceWithoutTax);
    final totalStr = NumberFormatterApp.format(item.total);

    return ListTileApp(
      leading: const CircleAvatar(
        child: Icon(Icons.shopping_bag),
      ),
      title: TypographyApp(text: item.product!.name, variant: "subtitle1"),
      subtitle: Row(children: [
        TypographyApp(
            text: "$quantityStr x $amountStr $symbol".trim(), variant: "body1"),
        Expanded(child: Container()),
        TypographyApp(text: "$totalStr $symbol".trim(), variant: "body1")
      ]),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => onDelete(context: context),
      ),
    );
  }
}

class ListOrderItems extends StatelessWidget {
  final Function()? onAfterSave;

  const ListOrderItems({super.key, this.onAfterSave});

  Widget buildItem({
    required BuildContext context,
    required OrdersItemsResponse item,
  }) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  ListTileItem(
                    item: item,
                    onAfterSave: onAfterSave,
                  ),
                  const Divider(height: 1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    final List<OrdersItemsResponse> items = cartProvider.articles;
    final List<Widget> children =
        items.map((item) => buildItem(context: context, item: item)).toList();

    return ListViewScrollingInfinite(
      children: children,
    );
  }
}