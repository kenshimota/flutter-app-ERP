import 'package:flutter/material.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:flutter_app_erp/widgets/scaffold_app.dart';
import 'package:flutter_app_erp/widgets/users/show_list_users.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override 
  Widget build(BuildContext context){
    final authProvider = Provider.of<AuthProvider>(context);
    final String? token = authProvider.getToken();
    return ScaffoldApp(
      title: "Usuarios",
      body: ShowListUsers(token: token ?? ''),
    );
  }
}