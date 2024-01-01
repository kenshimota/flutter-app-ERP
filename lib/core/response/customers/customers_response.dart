
import 'dart:convert';
import 'package:flutter_app_erp/core/response/response_base.dart';

class CustomersResponse implements ResponseBase {
  final int id;
  final String name;
  final String lastName;
  final int identityDocument;
  final int stateId;
  final int cityId;
  final String? address;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CustomersResponse({
    required this.id,
    required this.name,
    required this.lastName,
    required this.identityDocument,
    required this.stateId,
    required this.cityId,
    this.address,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CustomersResponse.fromJson(Map<String, dynamic> json){

    return CustomersResponse(
      id: json["id"],
      name: json['name'], 
      lastName: json['last_name'], 
      identityDocument: json['identity_document'], 
      stateId: json['state_id'],
      cityId: json['city_id'], 
      address: json['address'],
      createdAt: DateTime.parse(json['created_at']), 
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  @override
  String toString(){
    final Map<String, dynamic> map = {
      "name": name,
      "lastName": lastName,
      "identityDocument": identityDocument,
      "stateId": stateId,
      "cityId": cityId,
      "address": address,
      "createdAt": createdAt.toString(),
      "updatedAt": updatedAt.toString(),
    };
    return jsonEncode(map);
  }


}