import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_app_erp/core/response/taxes/taxes_response.dart';

Future<List<TaxesResponse>> getListTaxes({required String token}) async {
  final env = dotenv.env;
  final String hostname = env['HOSTNAME_API'] ?? '';
  final Uri url = Uri.parse("$hostname/taxes");

  final Map<String, String> headers = {
    'content-Type': 'application/json',
    "Authorization": "Bearer $token",
  };

  http.Response response = await http.get(url, headers: headers);

  if (response.statusCode == 401) {
    final Map<String, dynamic> json = jsonDecode(response.body);
    throw Exception(json["Error"]);
  }

  final List<dynamic> json = jsonDecode(response.body);

  return json
      .map(
        (e) => TaxesResponse.fromJson(e),
      )
      .toList();
}
