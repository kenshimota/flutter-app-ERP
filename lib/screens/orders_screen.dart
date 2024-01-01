import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/orders/show_table_orders.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';

import 'package:provider/provider.dart';

import 'package:flutter_app_erp/widgets/scaffold_app.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final String? token = authProvider.getToken();
    
    return  ScaffoldApp(
      title: "Pedidos",
      body: ShowTableOrders(token: token ?? ''),
    );
  }
}