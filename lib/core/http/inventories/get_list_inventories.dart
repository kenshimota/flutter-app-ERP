import 'dart:convert';
import 'package:flutter_app_erp/core/exception/auth_errors.dart';
import 'package:flutter_app_erp/core/response/inventories/inventories_response.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<List<InventoryResponse>> getListInventories({
  required String token,
  String search = '',
  Map<String, String>? order,
  int page = 1,
}) async {
  final env = dotenv.env;
  final String hostname = env['HOSTNAME_API'] ?? '';
  String path = "$hostname/inventories?metadata=1&q=$search&page=$page";

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
        (e) => InventoryResponse.fromJson(e),
      )
      .toList();
}
