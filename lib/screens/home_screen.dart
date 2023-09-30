import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/http/taxes/get_list_taxes.dart';
import 'package:flutter_app_erp/core/response/taxes/taxes_response.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:flutter_app_erp/widgets/show_info_taxes_api.dart';
import 'package:flutter_app_erp/widgets/table_taxes.dart';
import 'package:flutter_app_erp/widgets/dialog.dart';
import 'package:flutter_app_erp/widgets/scaffold_app.dart';
import 'package:logger/logger.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> onRequest(String token) async {
    debugPrint(token);
    List<TaxesResponse> taxes = await getListTaxes(token: token);

    debugPrint(taxes.toString());
  }

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
      body:
          ShowInfoTaxes(), /*
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Expanded(
                  child: TablaExample(),
                ),
                Container(color: Colors.green, height: 100),
              ],
            ),
          )*/
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

/*
class TablaExample extends StatelessWidget {
  final Widget? child;
  const TablaExample({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: InteractiveViewer(
          child: Container(
            color: Colors.blue,
            height: 1800,
            width: 1880,
            child: child,
          ),
        ),
      ),
    );
  }
}

Widget botones() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        color: Colors.yellow,
        height: 1700,
        width: 1700,
      ),
    ),
  );
}
*/