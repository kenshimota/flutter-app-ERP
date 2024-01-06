import 'dart:convert';
import 'package:flutter_app_erp/core/response/response_base.dart';
import 'package:flutter_app_erp/core/response/products/products_response.dart';
import 'package:flutter_app_erp/core/response/orders/orders_response.dart';
import 'package:flutter_app_erp/core/response/currencies/currencies_response.dart';

class OrdersItemsResponse implements ResponseBase {
  final int productId;
  final int orderId;
  final int currencyId;
  final ProductsResponse? product;
  final OrdersResponse? order;
  final CurrenciesResponse? currency;
  final double priceWithutTax;
  final double price;
  final int quantity;
  final double subtotal;
  final double taxAmount;
  final double total;
  final DateTime createdAt;
  final DateTime updatedAt;
  Map<String, dynamic> attributes;

  OrdersItemsResponse({
    required this.productId,
    required this.orderId,
    required this.currencyId,
    required this.product,
    required this.order,
    required this.currency,
    required this.priceWithutTax,
    required this.price,
    required this.quantity,
    required this.subtotal,
    required this.taxAmount,
    required this.total,
    required this.createdAt,
    required this.updatedAt,
    required this.attributes,
    
  });

  factory OrdersItemsResponse.fromJson(Map<String, dynamic> json){
    return OrdersItemsResponse(
      productId: json['product_id'], 
      product: json["product"] == null ? null : ProductsResponse.fromJson(json["product"]),
      orderId: json['order_id'],
      order: json["order"] == null ? null : OrdersResponse.fromJson(json["order"]),
      currencyId: json['currency_id'], 
      currency: json["currency"] == null ? null : CurrenciesResponse.fromJson(json["currency"]),
      priceWithutTax: double.parse(json['price_withut:tax']),  
      price: double.parse( json['price'], ),
      quantity: json['quantity'], 
      subtotal: double.parse(json['subtotal']),
      taxAmount: double.parse(json['tax-amount']),
      total: double.parse(json['total']),
      createdAt: DateTime.parse(json['created_at']), 
      updatedAt:  DateTime.parse(json['updated_at']),
      attributes: json,
      
      
    );
  }

  @override
  String toString(){
    return jsonEncode(json);
  }
}
