import 'package:flutter/material.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';

import 'package:provider/provider.dart';
import 'package:flutter_app_erp/widgets/scaffold_app.dart';
import 'package:flutter_app_erp/widgets/show_info_taxes_api.dart';

class TaxesScreen extends StatelessWidget {
  const TaxesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final String? token = authProvider.getToken();

    return ScaffoldApp(
      title: "Impuestos",
      body: ShowInfoTaxes(token: token ?? ''),
    );
  }
}
