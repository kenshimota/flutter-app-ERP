import 'dart:convert';
import 'package:flutter/material.dart';

class CurrenciesResponse {
  final int id;
  final String name;
  final String symbol;
  final String code;
  final double exchangeRate;
  final DateTime createdAt;
  final DateTime updatedAt;


  const CurrenciesResponse({
    required this.id,
    required this.name,
    required this.symbol,
    required this.code,
    required this.exchangeRate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CurrenciesResponse.fromJson(Map<String, dynamic> json) {

    debugPrint('$json');

    return CurrenciesResponse(
      id: json['id'],
      name: json['name'],
      symbol: json['symbol'],
      code: json['code'],
      exchangeRate: double.parse(json['exchange_rate']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  @override
  String toString() {
    final Map<String, dynamic> map = {
      "id":id,
      "name": name,
      "symbol": symbol,
      "code": code,
      "exchangeRate": exchangeRate,
      "createdAt": createdAt.toString(),
      "updatedAt": updatedAt.toString(),
    };

    return jsonEncode(map);
  }
}
