import 'dart:convert';
import 'dart:ffi';

class TaxesResponse {
  final String name;
  final double percentage;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TaxesResponse({
    required this.name,
    required this.percentage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TaxesResponse.fromJson(Map<String, dynamic> json) {
    return TaxesResponse(
      name: json['name'],
      percentage: double.parse(json['percentage']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  @override
  String toString() {
    final Map<String, dynamic> map = {
      "name": this.name,
      "percetange": this.percentage,
      "createdAt": this.createdAt.toString(),
      "updatedAt": this.updatedAt.toString(),
    };

    // TODO: implement toString
    return jsonEncode(map);
  }
}
