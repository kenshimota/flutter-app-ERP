import 'dart:convert';
import 'package:flutter_app_erp/core/exception/auth_errors.dart';
import 'package:flutter_app_erp/core/response/orders_items/orders_items_response.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<OrdersItemsResponse> getOrderItem({
  required String token,
  required int itemId,
}) async {
  final env = dotenv.env;
  final String hostname = env['HOSTNAME_API'] ?? '';
  String path = "$hostname/orders_items/$itemId";

  final Map<String, String> hearders = {
    'content-Type': 'application/json',
    "Authorization": "Bearer $token",
  };

  final Uri url = Uri.parse(path);

  http.Response response = await http.get(url, headers: hearders);

  if (response.statusCode == 401) {
    final Map<String, dynamic> json = jsonDecode(response.body);
    throw AuthErrors(message: json["error"]);
  }

  if (response.statusCode == 404) {
    const String msg = 'El pedido solicitado no fue encontrado';
    throw Exception(msg);
  }

  final Map<String, dynamic> json = jsonDecode(response.body);
  return OrdersItemsResponse.fromJson(json);
}