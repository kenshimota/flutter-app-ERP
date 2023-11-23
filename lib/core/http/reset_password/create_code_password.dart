import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<bool> createCodePassword({
  required String email,
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
    }
  });

  http.Response response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 404) {
    throw Exception(
      "El correo electronico ingresado no fue encontrado, verifique el email ingresado",
    );
  }

  return 201 == response.statusCode;
}
