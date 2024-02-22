import 'dart:convert';
import 'package:flutter_app_erp/core/exception/auth_errors.dart';
import 'package:flutter_app_erp/core/exception/form_errors.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_app_erp/core/response/users/user_response.dart';

Future<UserResponse> createUser({
  required String username,
  required String password,
  required String firstName,
  required String lastName,
  required int identityDocument,
  required String email,
  required int stateId,
  required int cityId,
}) async {
  final env = dotenv.env;
  final String hostname = env['HOSTNAME_API'] ?? '';
  final Uri url = Uri.parse("$hostname/users");

  final Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8'
  };

  String body = jsonEncode({
    "customer": {
      "name": firstName,
      "last_name": lastName,
      "identity_document": identityDocument,
      "state_id": stateId,
      "city_id": cityId,
    },
    "user": {
      "username": username,
      "first_name": firstName,
      "last_name": lastName,
      "password": password,
      "identity_document": identityDocument,
      "email": email,
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

  final String? authorization = response.headers["authorization"];
  final Map<String, dynamic> json = jsonDecode(response.body);
  final UserResponse user = UserResponse.fromJson(json);

  if (authorization != null) {
    user.token = authorization.split(" ").last;
  }

  return user;
}
