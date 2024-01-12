import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/http/orders/get_order.dart';
import 'package:flutter_app_erp/core/response/orders/orders_response.dart';
import 'package:flutter_app_erp/core/http/ordens_items/create_order_item.dart';
import 'package:flutter_app_erp/core/http/ordens_items/get_list_orders_items.dart';
import 'package:flutter_app_erp/core/response/orders_items/orders_items_response.dart';

class CartProvider extends ChangeNotifier {
  final int orderId;
  Future? futureList;
  OrdersResponse? order;
  final List<OrdersItemsResponse> articles = [];

  CartProvider({required this.orderId, required String token}) {
    getItems(token: token);
  }

  Future<void> getDataNotify({required String token}) async {
    futureList = getData(token: token);
    notifyListeners();
  }

  Future<void> getData({required String token}) async {
    getOrderData(token: token);
    getItems(token: token);
  }

  Future<void> getOrderData({required String token}) async {
    final OrdersResponse data = await getOrder(token: token, orderId: orderId);
    order = data;
  }

  Future<void> getItems({required String token}) async {
    final List<OrdersItemsResponse> list =
        await getListOrdersItemsResponse(token: token);

    for (final OrdersItemsResponse item in list) {
      articles.add(item);
    }
  }

  Future<void> addItem({
    required int productId,
    required int quantity,
    required String token,
  }) async {
    final OrdersItemsResponse item = await createOrdersItems(
      orderId: orderId,
      productId: productId,
      quantity: quantity,
      token: token,
    );

    articles.add(item);

    getOrderData(token: token);

    notifyListeners();
  }
}
