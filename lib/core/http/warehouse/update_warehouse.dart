import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_app_erp/core/exception/form_errors.dart';
import 'package:flutter_app_erp/core/response/warehouse/warehouse_response.dart';

Future<WarehouseResponse> updateWarehouse({
  required int wareId,
  required String name,
  String? address,
   required String? token,
}) async {
  final env = dotenv.env;
  final String hostname = env['HOSTNAME_API'] ?? '';
  final Uri url = Uri.parse("$hostname/warehouses/$wareId");


  final Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    "Authorization": "Bearer $token",
  };

  String body = jsonEncode({
    "warehouse": {
      "name": name,
      "address": address,
    }
  });

   http.Response response = await http.patch(url, headers: headers, body: body);
    if (response.statusCode == 404) {
    throw Exception("Hay ocurrido un error en la red, revise su conexión");
  }

  if (response.statusCode == 401) {
    final Map<String, dynamic> json = jsonDecode(response.body);
    throw Exception(json["error"]);
  }
  if (response.statusCode == 422) {
    final Map<String, dynamic> json = jsonDecode(response.body);
    final Map<String, dynamic> map = json["errors"] ?? {};
    throw FormErrors(map: map);
  }

  if (response.statusCode >= 500) {
    const String msg =
        'Hubo un error inesperado en el servidor contacte a su provedor.';
    throw Exception(msg);
  }

  final Map<String, dynamic> json = jsonDecode(response.body);

  return WarehouseResponse.fromJson(json);

}