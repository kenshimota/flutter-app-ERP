import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/exception/auth_errors.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_app_erp/core/response/users/user_response.dart';

Future<UserResponse> createSession({
  required String username,
  required String password,
}) async {
  final env = dotenv.env;
  final String hostname = env['HOSTNAME_API'] ?? '';
  final Uri url = Uri.parse("$hostname/users/sign_in");

  final Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8'
  };

  String body = jsonEncode({
    "user": {"username": username, "password": password}
  });

  debugPrint(url.toString());

  http.Response response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 404) {
    throw Exception("Hay ocurrido un error en la red, revise su conexión");
  }

  if (response.statusCode == 401) {
    final Map<String, dynamic> json = jsonDecode(response.body);
    throw AuthErrors(message: json["error"]);
  }

  final String? authorization = response.headers["authorization"];
  final Map<String, dynamic> json = jsonDecode(response.body);
  final UserResponse user = UserResponse.fromJson(json);

  if (authorization != null) {
    user.token = authorization.split(" ").last;
  }

  if (response.statusCode >= 500) {
    const String msg =
        'Hubo un error inesperado en el servidor contacte a su provedor.';
    throw Exception(msg);
  }
  return user;
}
