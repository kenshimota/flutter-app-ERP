import 'package:flutter/material.dart';

import 'package:flutter_app_erp/widgets/scaffold_app.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldApp(
      body: Text("Inicio home"),
    );
  }
}
