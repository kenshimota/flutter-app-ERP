import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;


Future<bool> deleteTax({ required int id, required String token  }) async {

   final env = dotenv.env;
  final String hostname = env['HOSTNAME_API'] ?? '';
  final Uri url = Uri.parse("$hostname/taxes/$id");

  final Map<String, String> headers = {
    'content-Type': 'application/json',
    "Authorization": "Bearer $token",
  };

  http.Response response = await http.delete(url, headers: headers);


  return 204 == response.statusCode;
}
