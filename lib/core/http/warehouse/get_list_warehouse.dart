import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/exception/auth_errors.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_app_erp/core/response/warehouse/warehouse_response.dart';

Future<List<WarehouseResponse>> getListWarehouse(
    {required String token,
    String search = '',
    Map<String, String>? order,
    int page = 1,
    Future? futureDelete}) async {
  final env = dotenv.env;
  final String hostname = env['HOSTNAME_API'] ?? '';
  String path = "$hostname/warehouses?q=$search&page=$page&";

  if (order != null &&
      order.containsKey('field') &&
      order.containsKey('type')) {
    path =
        "$path&order_by[field]=${order['field']}&order_by[order]=${order['type']}";
  }

  final Map<String, String> headers = {
    'content-Type': 'application/json',
    "Authorization": "Bearer $token",
  };

  final Uri url = Uri.parse(path);

  debugPrint(url.toString());

  http.Response response = await http.get(url, headers: headers);

  debugPrint('$response');

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

  debugPrint('$response');

  return json
      .map(
        (e) => WarehouseResponse.fromJson(e),
      )
      .toList();
}
