import 'package:flutter/material.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:flutter_app_erp/widgets/products_prices/show_table_products_prices.dart';

import 'package:provider/provider.dart';

import 'package:flutter_app_erp/widgets/scaffold_app.dart';

class ProductsPricesScreen extends StatelessWidget {
  const ProductsPricesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final String? token = authProvider.getToken();
    
    return  ScaffoldApp(
      title: "Precios",
      body: ShowTableProductsPrices(token: token ?? '' ),
    );
  }
}