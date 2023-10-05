import 'package:flutter/material.dart';

import 'package:flutter_app_erp/widgets/show_info_taxes_api.dart';
import 'package:flutter_app_erp/widgets/scaffold_app.dart';
import 'package:logger/logger.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  onPressed() {
    Logger logger = Logger();
    logger.w("test: fluytter");
  }

  onPretion(BuildContext context) {
    context.go("/signup");
  }

  @override
  Widget build(BuildContext context) {
    return const ScaffoldApp(
      body: ShowInfoTaxes(rows: [],),
    );
  }
}

class TablaExample extends StatelessWidget {
  const TablaExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Row(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              height: 100,
              width: 2000,
              color: Colors.yellow,
            ),
          ),
        ],
      ),
    );
  }
}
