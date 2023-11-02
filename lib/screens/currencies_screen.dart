import 'package:flutter/material.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_erp/widgets/scaffold_app.dart';
import 'package:flutter_app_erp/widgets/show_table_currencies.dart';

class CurrenciesScreen extends StatelessWidget {
  const CurrenciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final String? token = authProvider.getToken();
    return ScaffoldApp(
      body: ShowTableCurrencies(token: token ?? ''),
    );
  }
}
