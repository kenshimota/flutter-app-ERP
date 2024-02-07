import 'dart:convert';
import 'package:flutter_app_erp/core/response/response_base.dart';
import 'package:flutter_app_erp/core/response/taxes/taxes_response.dart';

class ProductsResponse implements ResponseBase {
  final int id;
  final int stock;
  final int reserved;
  final String code;
  final String name;
  final String? barCode;
  final TaxesResponse? tax;
  final DateTime createdAt;
  final DateTime updatedAt;
  Map<String, dynamic> attributes;

  ProductsResponse({
    required this.id,
    required this.tax,
    required this.name,
    required this.code,
    required this.stock,
    required this.reserved,
    required this.barCode,
    required this.createdAt,
    required this.updatedAt,
    required this.attributes,
  });

  factory ProductsResponse.fromJson(Map<String, dynamic> json) {
    return ProductsResponse(
      id: json['id'],
      attributes: json,
      name: json['name'],
      code: json['code'],
      barCode: json['bar_code'] ?? "",
      stock: json["stock"],
      reserved: json["reserved"],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      tax: json["tax"] != null ? TaxesResponse.fromJson(json["tax"]) : null,
    );
  }

  @override
  String toString() {
    return jsonEncode(attributes);
  }
}
