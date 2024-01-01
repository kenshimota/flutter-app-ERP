import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_app_erp/core/exception/auth_errors.dart';
import 'package:flutter_app_erp/core/exception/form_errors.dart';
import 'package:flutter_app_erp/core/response/customers/customers_response.dart';

Future<CustomersResponse> createCustomer({
  required String token,
  required String name,
  required String lastName,
  required int identityDocument,
  required String address,
  required int stateId, 
  required int cityId,
}) async {
  final env = dotenv.env;
  final String hostname = env['HOSTNAME_API'] ?? '';
  final Uri url = Uri.parse("$hostname/customers");

  final Map<String, String> hearders = {
    'Content-Type': 'application/json; charset=UTF-8',
    "Authorization": "Bearer $token",
  };

  String body = jsonEncode({
    "customer": {
      "name": name,
      "last_name": lastName,
      "identity_document": identityDocument,
      "address": address,
      "state_id": stateId,
      "city_id": cityId,
    }
  });

  http.Response response = await http.post(url, headers: hearders, body: body);
  

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
  return CustomersResponse.fromJson(json);
}
