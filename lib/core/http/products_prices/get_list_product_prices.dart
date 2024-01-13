import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_app_erp/core/exception/auth_errors.dart';
import 'package:flutter_app_erp/core/response/products_prices/products_prices_response.dart';

Future<List<ProductsPricesResponse>> getListProductsPrices({
  required String token,
  String search = '',
  int page = 1,
  int? currencyId,
  int? takeOffOrderId,
  bool onlyAvailable = false,
  Map<String, dynamic>? order,
  bool metadata = false,
}) async {
  final env = dotenv.env;
  final String hostname = env['HOSTNAME_API'] ?? '';
  String path = "$hostname/products_prices?q=$search&page=$page&";

  final Map<String, String> headers = {
    'content-Type': 'application/json',
    "Authorization": "Bearer $token",
  };

  if (order != null &&
      order.containsKey('field') &&
      order.containsKey('type')) {
    path =
        '$path&order_by[field]=${order['field']}&order_by[order]=${order['type']}';
  }

  if (metadata) {
    path = "$path&metadata=1";
  }

  if (onlyAvailable) {
    path = "$path&available=1";
  }

  if (currencyId != null) {
    path = "$path&currency_id=$currencyId";
  }

  if (takeOffOrderId != null) {
    path = "$path&filter_order_id=${takeOffOrderId}";
  }

  final Uri url = Uri.parse(path);

  http.Response response = await http.get(url, headers: headers);

  if (response.statusCode == 401) {
    final Map<String, dynamic> json = jsonDecode(response.body);
    throw AuthErrors(message: json["error"]);
  }

  if (response.statusCode >= 500) {
    const String msg =
        'Hubo un error inesperado en el servidor contacte a su provedor.';
    throw Exception(msg);
  }

  final List<dynamic> json = jsonDecode(response.body);

  return json
      .map(
        (e) => ProductsPricesResponse.fromJson(e),
      )
      .toList();
}
