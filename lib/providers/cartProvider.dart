import "dart:io";
import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/http/ordens_items/delete_order_item.dart';
import 'package:flutter_app_erp/core/http/ordens_items/get_order_item.dart';
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
    getDataNotify(token: token);
    notifyListeners();
  }

  Future<void> getDataNotify({required String token}) async {
    futureList = getData(token: token);
  }

  Future<void> getData({required String token}) async {
    debugPrint("--- getData ----");
    await getOrderData(token: token);
    await getItems(token: token);
    notifyListeners();
  }

  Future<void> getOrderData({required String token}) async {
    debugPrint("----  getOrderData ----");
    final OrdersResponse data = await getOrder(token: token, orderId: orderId);
    order = data;
      debugPrint("---- Finish getOrderData ----");
  }

  Future<void> getItems({required String token}) async {
    debugPrint("----  getItems ----");
    int page = 1;

    List<OrdersItemsResponse> list = [];

       debugPrint("---- While getItems ----");

    while (list.length == 20 * (page - 1)) {
      debugPrint("${page} --- ${list.length}");

      list = await getListOrdersItemsResponse(
        token: token,
        page: page,
        orderId: orderId,
        metadata: true,
      );

      for (final OrdersItemsResponse item in list) {
        articles.add(item);
      }

      page += 1;
    }

    debugPrint("---- After While getItems ----");
    debugPrint("---- Finish getItems ----");
  }

  Future<void> addItem({
    required int productId,
    required int quantity,
    required String token,
  }) async {
    debugPrint("---- addItem ---");

    final OrdersItemsResponse item = await createOrdersItems(
      orderId: orderId,
      productId: productId,
      quantity: quantity,
      token: token,
    );

    const duration = Duration(milliseconds: 300);
    sleep(duration);

    final OrdersItemsResponse data =
        await getOrderItem(token: token, itemId: item.id);

    articles.add(data);

    await getOrderData(token: token);
    
    debugPrint("---- Finish addItem ---");
    notifyListeners();
  }

  Future<void> removeItem({required int itemId, required String token}) async {
    final bool deleted = await deleteOrdersItems(token: token, id: itemId);

    if (!deleted) {
      return;
    }

    final List<OrdersItemsResponse> newList =
        articles.where((element) => element.id != itemId).toList();

    for (int i = 0; i < newList.length; i++) {
      articles[i] = newList[i];
    }

    while (articles.length > newList.length) {
      articles.removeLast();
    }

    await getOrderData(token: token);

    notifyListeners();
  }
}
