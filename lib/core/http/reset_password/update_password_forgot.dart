import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_app_erp/core/exception/form_errors.dart';

Future<bool> updatePasswordForgot({
  required String email,
  required String code,
  required String password,
}) async {
  final env = dotenv.env;
  final String hostname = env['HOSTNAME_API'] ?? '';
  final Uri url = Uri.parse("$hostname/reset_passwords");

  final Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  String body = jsonEncode({
    "user": {
      "email": email,
      "reset_code": code,
      "password": password,
    }
  });

  http.Response response = await http.put(url, headers: headers, body: body);

  if (response.statusCode == 404) {
    throw Exception(
      "El correo electronico ingresado no fue encontrado, verifique el email ingresado",
    );
  }

  if (response.statusCode == 422) {
    final Map<String, dynamic> json = jsonDecode(response.body);
    final Map<String, dynamic> map = json["errors"] ?? {};
    throw FormErrors(map: map);
  }

  return 202 == response.statusCode;
}
