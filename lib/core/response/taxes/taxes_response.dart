import 'dart:convert';

class TaxesResponse {
  final int id;
  final String name;
  final double percentage;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TaxesResponse({
    required this.id,
    required this.name,
    required this.percentage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TaxesResponse.fromJson(Map<String, dynamic> json) {
    return TaxesResponse(
      id: json['id'],
      name: json['name'],
      percentage: double.parse(json['percentage']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  @override
  String toString() {
    final Map<String, dynamic> map = {
      "id": id,
      "name": name,
      "percetange": percentage,
      "createdAt": createdAt.toString(),
      "updatedAt": updatedAt.toString(),
    };

    return jsonEncode(map);
  }
}
