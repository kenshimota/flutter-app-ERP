import 'dart:convert';
import 'package:flutter_app_erp/core/response/response_base.dart';
import 'package:flutter_app_erp/core/response/products/products_response.dart';
import 'package:flutter_app_erp/core/response/warehouse/warehouse_response.dart';

class InventoryResponse implements ResponseBase {
  final int id;
  final int productId;
  final int stock;
  final int reserved;
  final int warehouseId;
  final String? observations;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ProductsResponse? product;
  final WarehouseResponse? warehouse;

  const InventoryResponse({
    required this.id,
    required this.warehouseId,
    required this.productId,
    required this.createdAt,
    required this.updatedAt,
    this.stock = 0,
    this.reserved = 0,
    this.product,
    this.warehouse,
    this.observations,
  });

  factory InventoryResponse.fromJson(Map<String, dynamic> json) {
    return InventoryResponse(
      id: json['id'],
      stock: json["stock"] ?? 0,
      reserved: json["reserved"] ?? 0,
      productId: json["product_id"],
      warehouseId: json["warehouse_id"],
      observations: json["observations"],
      warehouse: json["warehouse"] == null
          ? null
          : WarehouseResponse.fromJson(json["warehouse"]),
      product: json["product"] == null
          ? null
          : ProductsResponse.fromJson(json["product"]),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  @override
  String toString() {
    final Map<String, dynamic> map = {
      "id": id,
      "stock": stock,
      "reserved": reserved,
      "product": product == null ? null : jsonDecode(product.toString()),
      "warehouse": warehouse == null ? null : jsonDecode(warehouse.toString()),
      "product_id": productId,
      "warehouse_id": warehouseId,
      "createdAt": createdAt.toString(),
      "updatedAt": updatedAt.toString(),
    };

    return jsonEncode(map);
  }
}
