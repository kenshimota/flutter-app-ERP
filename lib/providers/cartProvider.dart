import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/response/orders_items/orders_items_response.dart';

class CartProvider extends ChangeNotifier {
  final List<OrdersItemsResponse> articles = [];

}