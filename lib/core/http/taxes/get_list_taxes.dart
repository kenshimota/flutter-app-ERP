import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_app_erp/core/response/taxes/taxes_response.dart';

Future<List<TaxesResponse>> getListTaxes({
  required String token,
  String search = '',
  Map<String, String>? order,
  int page = 1,
  Future? futureDelete
}) async {
  final env = dotenv.env;
  final String hostname = env['HOSTNAME_API'] ?? '';
  String path = "$hostname/taxes?q=$search&page=$page&";

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

  debugPrint(path);
  final Uri url = Uri.parse(path);

  http.Response response = await http.get(url, headers: headers);


  debugPrint("${response.statusCode} ${response.body}");

  if (response.statusCode == 401) {
    debugPrint('se me cerro la sesion');
    final Map<String, dynamic> json = jsonDecode(response.body);
    throw Exception(json["Error"]);
  }

  if(response.statusCode >= 500){
    const String msg = 'Hubo un error inesperado en el servidor contacte a su provedor.';
    debugPrint(msg);
    throw Exception(msg);
  }

  final List<dynamic> json = jsonDecode(response.body);

  return json
      .map(
        (e) => TaxesResponse.fromJson(e),
      )
      .toList();
}
