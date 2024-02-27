import 'package:flutter_app_erp/core/response/response_base.dart';

class UserResponse implements ResponseBase {
  final int id;
  final String email;
  final String username;
  final String firstName;
  final String lastName;
  final int identityDocument;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String roleId;
  final int customerId;
  String? token;

  UserResponse({
    required this.id,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.identityDocument,
    required this.createdAt,
    required this.updatedAt,
    required this.roleId,
    required this.customerId,
    this.token,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      token: "",
      identityDocument: json['identity_document'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      roleId: json["role"] != null ? json["role"]["name"] : "customer",
      customerId: json["customer"] != null ? json["customer"]["id"] : -1,
    );
  }
}
