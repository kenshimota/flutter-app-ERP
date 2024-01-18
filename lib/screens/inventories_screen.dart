import 'package:flutter/material.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:flutter_app_erp/widgets/inventories/show_info_inventories.dart';
import 'package:flutter_app_erp/widgets/scaffold_app.dart';
import 'package:provider/provider.dart';

class InventoriesScreen extends StatelessWidget {
  const InventoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final String? token = authProvider.getToken();

    return ScaffoldApp(
      title: "Inventario",
      body: ShowInfoInventories(token: token ?? ''),
    );
  }
}
