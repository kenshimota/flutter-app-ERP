import 'dart:convert';
import 'package:flutter_app_erp/core/response/response_base.dart';
import 'package:flutter_app_erp/core/response/customers/customers_response.dart';
import 'package:flutter_app_erp/core/response/currencies/currencies_response.dart';
import 'package:flutter_app_erp/core/response/users/user_response.dart';

class OrdersResponse implements ResponseBase {
  final int id;
  final int customerId;
  final int currencyId;
  final int userId;
  final int number;
  final double subtotal;
  final double taxAmount;
  final double total;
  final int productsCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int orderStatusId;
  final CustomersResponse? customer;
  final CurrenciesResponse? currency;
  final UserResponse? user;
  Map<String, dynamic> attributes;

  OrdersResponse({
    required this.id,
    required this.customerId,
    required this.currencyId,
    required this.number,
    required this.subtotal,
    required this.taxAmount,
    required this.total,
    required this.productsCount,
    required this.createdAt,
    required this.updatedAt,
    this.customer,
    this.currency,
    this.user,
    required this.orderStatusId,
    required this.attributes,
    required this.userId,
  });

  factory OrdersResponse.fromJson(Map<String, dynamic> json) {
    return OrdersResponse(
      id: json['id'],
      customerId: json['customer_id'],
      attributes: json,
      user: json["user"] == null ? null : UserResponse.fromJson(json["user"]),
      userId: json["user_id"],
      currencyId: json['currency_id'],
      number: json["number"],
      subtotal: double.parse(json["subtotal"]),
      total: double.parse(json["total"]),
      productsCount: json["products_count"],
      taxAmount: double.parse(json["tax_amount"]),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      orderStatusId: json["orders_status_id"],
      customer: json["customer"] != null
          ? CustomersResponse.fromJson(json["customer"])
          : null,
      currency: json["currency"] != null
          ? CurrenciesResponse.fromJson(json["currency"])
          : null,
    );
  }

  @override
  String toString() {
    return jsonEncode(json);
  }
}
