import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/exception/auth_errors.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_app_erp/core/exception/form_errors.dart';
import 'package:flutter_app_erp/core/response/currencies/currencies_response.dart';

Future<CurrenciesResponse> updateCurrencie({
  required int currencieId,
  required String name,
  required String symbol,
  required String code,
  required double exchangeRate,
  required String? token,
}) async {
  final env = dotenv.env;
  final String hostname = env['HOSTNAME_API'] ?? '';
  final Uri url = Uri.parse("$hostname/currencies/$currencieId");

  final Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    "Authorization": "Bearer $token",
  };

  String body = jsonEncode({
    "currency": {
      "name": name,
      "symbol": symbol,
      "code": code,
      "excgangeRate": exchangeRate,
    }
  });

  http.Response response = await http.patch(url, headers: headers, body: body);

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
    debugPrint('$json');
    throw FormErrors(map: map);
  }

  if (response.statusCode >= 500) {
    const String msg =
        'Hubo un error inesperado en el servidor contacte a su provedor.';
    throw Exception(msg);
  }

  final Map<String, dynamic> json = jsonDecode(response.body);

  return CurrenciesResponse.fromJson(json);
}
