class UserResponse {
  final int id;
  final String email;
  final String username;
  final String firstName;
  final String lastName;
  final int identityDocument;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserResponse({
    required this.id,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.identityDocument,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      identityDocument: json['identity_document'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
