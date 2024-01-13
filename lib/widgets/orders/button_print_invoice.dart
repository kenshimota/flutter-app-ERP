import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/http/ordens_items/get_all_orders_items.dart';
import 'package:flutter_app_erp/core/http/orders/get_order.dart';
import 'package:flutter_app_erp/core/response/orders/orders_response.dart';
import 'package:flutter_app_erp/core/response/orders_items/orders_items_response.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:flutter_app_erp/widgets/shoppingCart/print_invoice_from_order.dart';
import 'package:provider/provider.dart';

class ButtonPrintInvoice extends StatelessWidget {
  final int orderId;

  const ButtonPrintInvoice({super.key, required this.orderId});

  Future<void> onRequestApi(String token) async {
    final OrdersResponse order = await getOrder(token: token, orderId: orderId);
    final List<OrdersItemsResponse> articles =
        await getAllOrdersItems(token: token, orderId: orderId);
    await printInvoiceFromOrder(order: order, articles: articles);
  }

  onPressed(String token) {
    onRequestApi(token);
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final String token = authProvider.getToken() as String;

    return IconButton(
      onPressed: () => onPressed(token),
      icon: const Icon(Icons.print),
    );
  }
}
