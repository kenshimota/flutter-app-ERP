import 'package:flutter/material.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:flutter_app_erp/widgets/products/show_info_products.dart';

import 'package:provider/provider.dart';
import 'package:flutter_app_erp/widgets/scaffold_app.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final String? token = authProvider.getToken();

    return ScaffoldApp(
      title: "Productos",
      body: ShowInfoProducts(token: token ?? ''),
    );
  }
}
