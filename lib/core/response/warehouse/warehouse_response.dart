import 'dart:convert';
import 'package:flutter_app_erp/core/response/response_base.dart';

class WarehouseResponse implements ResponseBase {
  final int id;
  final String name;
  final String address;
  final DateTime createdAt;
  final DateTime updatedAt;

  const WarehouseResponse({
    required this.id,
    required this.name,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WarehouseResponse.fromJson(Map<String, dynamic> json) {
    return WarehouseResponse(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  @override
  String toString() {
    final Map<String, dynamic> map = {
      "id": id,
      "name": name,
      "percetange": address,
      "createdAt": createdAt.toString(),
      "updatedAt": updatedAt.toString(),
    };

    return jsonEncode(map);
  }
}
