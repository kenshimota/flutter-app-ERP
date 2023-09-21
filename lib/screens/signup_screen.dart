import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/container_limit.dart';
import 'package:flutter_app_erp/widgets/form_signup.dart';
import 'package:logger/logger.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  onPressed() {
    Logger logger = Logger();
    logger.w("test: fluytter");
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ContainerLimit(
        maxWidth: 600,
        child: FormSignup(),
      ),
    );
  }
}
