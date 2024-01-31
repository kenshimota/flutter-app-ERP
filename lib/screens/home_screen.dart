import 'package:flutter/material.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:flutter_app_erp/widgets/home/home_information.dart';

import 'package:flutter_app_erp/widgets/scaffold_app.dart';
import 'package:flutter_app_erp/widgets/typography.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final String? token = authProvider.getToken();

    return  ScaffoldApp(
      title: "Inicio",
      body: ShowHomeInformation(token: token ?? '',),
    );
  }
}
