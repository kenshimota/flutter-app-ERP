import 'dart:convert';
import 'package:flutter_app_erp/core/response/response_base.dart';
import 'package:flutter_app_erp/core/response/currencies/currencies_response.dart';
import 'package:flutter_app_erp/core/response/products/products_response.dart';

class ProductsPricesResponse implements ResponseBase {
  final int id;
  final int currencyId;
  final int productId;
  final CurrenciesResponse? currency;
  final ProductsResponse? product;
  final double price;
  final DateTime createdAt;
  final DateTime updatedAt;
  Map<String, dynamic> attributes;
 
  ProductsPricesResponse({
    required this.id,
    required this.currencyId,
    required this.productId,
    this.currency,
    this.product,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.attributes,
  });

  factory ProductsPricesResponse.fromJson(Map<String, dynamic> json){
    return ProductsPricesResponse(
      id: json["id"],
      currencyId: json["currency_id"],
      productId: json["product_id"],
      attributes: json,
      currency: json["currency"] != null ? CurrenciesResponse.fromJson(json["currency"]) : null,
      product: json["product"] != null ? ProductsResponse.fromJson(json["product"]) : null,
      price: double.parse(json['price']),
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),

    );
  }

  @override
  String toString(){
    return jsonEncode(attributes);
  }
}