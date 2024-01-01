import 'dart:convert';
import 'package:flutter_app_erp/core/response/response_base.dart';
import 'package:flutter_app_erp/core/response/currencies/currencies_response.dart';
import 'package:flutter_app_erp/core/response/products/products_response.dart';

class ProductsPricesResponse implements ResponseBase {
  final CurrenciesResponse? currency;
  final ProductsResponse? product;
  final double price;
  Map<String, dynamic> attributes;
 
  ProductsPricesResponse({
    this.currency,
    this.product,
    required this.price,
    required this.attributes,
  });

  factory ProductsPricesResponse.fromJson(Map<String, dynamic> json){
    return ProductsPricesResponse(
      attributes: json,
      currency: json["currency"] != null ? CurrenciesResponse.fromJson(json["currency"]) : null,
      product: json["product"] != null ? ProductsResponse.fromJson(json["product"]) : null,
       price: double.parse(json['price']),
    );
  }

  @override
  String toString(){
    return jsonEncode(attributes);
  }
}