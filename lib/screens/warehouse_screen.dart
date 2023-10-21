import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/show_table_warehouse.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_erp/widgets/scaffold_app.dart';

class WarehouseScreen extends StatelessWidget {

  const WarehouseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    
   final authProvider = Provider.of<AuthProvider>(context);
    final String? token = authProvider.getToken();

    return  ScaffoldApp(
      body: ShowTableWarehouse(token: token ?? '',),
    );
  }
}