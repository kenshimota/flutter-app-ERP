import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/http/users/create_user.dart';
import 'package:flutter_app_erp/core/http/sessions/create_session.dart';
import 'package:flutter_app_erp/core/response/users/user_response.dart';

class AuthProvider extends ChangeNotifier {
  UserResponse? _currentUser;

  String? getToken() {
    return _currentUser?.token;
  }

  bool hasSession() {
    return _currentUser != null;
  }

  Future<void> signIn({
    required String username,
    required String password,
  }) async {
    final UserResponse user = await createSession(
      username: username,
      password: password,
    );

    _currentUser = user;
    notifyListeners();
  }

  Future<void> signUp({
    required String username,
    required String password,
    required String firstName,
    required String lastName,
    required int identityDocument,
    required String email,
  }) async {
    final UserResponse user = await createUser(
      username: username,
      password: password,
      firstName: firstName,
      lastName: lastName,
      identityDocument: identityDocument,
      email: email,
    );

    _currentUser = user;
  }

  Future<void> signOut() async {
    _currentUser = null;
    notifyListeners();
  }
}
