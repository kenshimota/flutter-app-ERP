import 'package:flutter/material.dart';

import 'package:flutter_app_erp/widgets/scaffold_app.dart';
import 'package:flutter_app_erp/widgets/typography.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldApp(
      title: "Inicio",
      body: TypographyApp(text: "Inicio home"),
    );
  }
}
