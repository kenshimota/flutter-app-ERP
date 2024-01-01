import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_app_erp/core/exception/auth_errors.dart';
import 'package:flutter_app_erp/core/exception/form_errors.dart';
import 'package:flutter_app_erp/core/response/orders/orders_response.dart';

Future<OrdersResponse> createOrders({
  required String token,
  required int customerId,
  required int currencyId, 
}) async {
  final env = dotenv.env; 
  final String hostname = env['HOSTNAME_API']  ?? '';
  final Uri url = Uri.parse("$hostname/orders");

  final Map<String, String> hearders = {
    'Content-Type': 'application/json; charset=UTF-8',
    "Authorization": "Bearer $token",
  };

  String body = jsonEncode({
    "order": {
      "customer_id": customerId,
      "currency_id": currencyId,
    }
  });

  http.Response response = await http.post(url, headers: hearders, body: body);

  debugPrint('${response.statusCode}');


  if (response.statusCode == 404) {
    throw Exception("Hay ocurrido un error en la red, revise su conexión");
  }

  if (response.statusCode == 401) {
    final Map<String, dynamic> json = jsonDecode(response.body);
    throw AuthErrors(message: json["error"]);
  }

  if (response.statusCode == 422) {
    final Map<String, dynamic> json = jsonDecode(response.body);
    final Map<String, dynamic> map = json["errors"] ?? {};
    throw FormErrors(map: map);
  }

  final Map<String, dynamic> json = jsonDecode(response.body);
  return OrdersResponse.fromJson(json);
}