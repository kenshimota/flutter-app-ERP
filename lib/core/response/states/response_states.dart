import 'dart:convert';
import 'package:flutter_app_erp/core/response/response_base.dart';

class StatesResponse implements ResponseBase {
  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  StatesResponse({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StatesResponse.fromJson(Map<String, dynamic> json) {
    return StatesResponse(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  @override
  String toString() {
    final Map<String, dynamic> map = {
      "id": id,
      "name": name,
      "createdAt": createdAt.toString(),
      "updatedAt": updatedAt.toString(),
    };

    return jsonEncode(map);
  }
}
