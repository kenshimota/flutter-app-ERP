import 'dart:convert';
import 'package:flutter_app_erp/core/response/inventories/inventories_response.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_app_erp/core/exception/auth_errors.dart';
import 'package:flutter_app_erp/core/exception/form_errors.dart';

Future<InventoryResponse> createInventory({
  required int productId,
  required int warehouseId,
  required int stock,
  required String? observations,
  required String token,
}) async {
  final env = dotenv.env;
  final String hostname = env['HOSTNAME_API'] ?? '';
  final Uri url = Uri.parse("$hostname/inventories");

  final Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    "Authorization": "Bearer $token",
  };

  String body = jsonEncode({
    "inventory": {
      "stock": stock,
      "product_id": productId,
      "warehouse_id": warehouseId,
      "observations": observations,
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
  return InventoryResponse.fromJson(json);
}
