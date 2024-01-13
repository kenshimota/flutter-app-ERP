import 'dart:convert';
import 'package:flutter_app_erp/core/exception/auth_errors.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_app_erp/core/response/orders_items/orders_items_response.dart';

Future<List<OrdersItemsResponse>> getListOrdersItemsResponse({
  required String token,
  int page = 1,
  int? orderId,
  bool metadata = false,
}) async {
  final env = dotenv.env;
  final String hostname = env['HOSTNAME_API'] ?? '';
  String path = "$hostname/orders_items?page=$page";

  final Map<String, String> headers = {
    'content-Type': 'application/json',
    "Authorization": "Bearer $token",
  };

  if (orderId != null) {
    path = "$path&order_id=$orderId";
  }

  if (metadata) {
    path = "$path&metadata=1";
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
        (e) => OrdersItemsResponse.fromJson(e),
      )
      .toList();
}
