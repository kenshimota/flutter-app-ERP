import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/dialog.dart';
import 'package:flutter_app_erp/widgets/drawer_app.dart';
import 'package:flutter_app_erp/widgets/scaffold_app.dart';
import 'package:logger/logger.dart';
import 'package:flutter/gestures.dart';
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
      body: DialogApp(),
    );
  }
}
