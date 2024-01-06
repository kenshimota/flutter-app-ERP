import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app_erp/core/exception/auth_errors.dart';
import 'package:flutter_app_erp/core/exception/form_errors.dart';
import 'package:flutter_app_erp/core/response/orders_items/orders_items_response.dart';

Future<OrdersItemsResponse> createOrdersItems({
  required int productId,
  required int orderId,
  required int currencyId,
  required double priceWithoutTax,
  required double price,
  required int quantity,
  required double subtotal,
  required double taxAmount,
  required double total,
  required String? token,
}) async {
  final env = dotenv.env;
  final String hostname = env['HOSTNAME_API'] ?? '';
  final Uri url = Uri.parse("$hostname/orders_items");

  final Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    "Authorization": "Bearer $token",
  };

  String body = jsonEncode({
    "order_item": {
      "product_id": productId,
      "order_id": orderId,
      "currency_id": currencyId,
      "price_without_tax": priceWithoutTax,
      "price": price,
      "quantity": quantity,
      "subtotal": subtotal,
      "tax_amount": taxAmount,
      "total": total,
    }
  });

   http.Response response = await http.post(url, headers: headers, body: body);

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
  return OrdersItemsResponse.fromJson(json);
}