import 'dart:convert';

class FormErrors {
  final Map<String, dynamic> map;

  FormErrors({required this.map});

  String? getValue(String key) {
    final List<dynamic> object = map[key] ?? [];
    final List<String> messages = object.map((e) => e.toString()).toList();

    if (messages.isEmpty) {
      return null;
    }

    return messages.join(", ");
  }

  @override
  String toString() {
    return jsonEncode(map);
  }
}
