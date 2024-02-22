import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/response/users/user_response.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class ProtectedChild extends StatelessWidget {
  final Widget child;
  final List<String> roles;

  const ProtectedChild({
    super.key,
    required this.child,
    required this.roles,
  });

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final UserResponse? current = authProvider.getCurrentUser();
    final String role = current == null ? '' :  roles.firstWhere((element) => element == current.roleId, orElse: () => '');

    if(role == '') {
      return const SizedBox(width: 0.0, height: 0.0);
    }

    return child;
  }
}
