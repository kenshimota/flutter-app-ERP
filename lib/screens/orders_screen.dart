import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/constants/roles_constants.dart';
import 'package:flutter_app_erp/core/response/users/user_response.dart';
import 'package:flutter_app_erp/widgets/orders/show_table_orders.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';

import 'package:provider/provider.dart';

import 'package:flutter_app_erp/widgets/scaffold_app.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int? customerId;
    final authProvider = Provider.of<AuthProvider>(context);
    final String? token = authProvider.getToken();
    final UserResponse? current = authProvider.getCurrentUser();

    if(current == null) {
      return const SizedBox(width: 0, height: 0,);
    }
    
    if(current.roleId == RolesConstants.customer()) { 
      customerId = current.customerId;
    }

    return ScaffoldApp(
      title: "Pedidos",
      body: ShowTableOrders(
        token: token ?? '',
        customerId: customerId,
      ),
    );
  }
}
