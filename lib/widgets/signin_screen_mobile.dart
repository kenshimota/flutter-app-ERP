import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/container_limit.dart';
import 'package:flutter_app_erp/widgets/form_signin_request.dart';

class SigninScreenMobile extends StatelessWidget {
  const SigninScreenMobile({super.key});

  onPressed() {
    Logger logger = Logger();
    logger.w("test: fluytter");
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ContainerLimit(
        maxWidth: 500,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: FormSigninRequest(),
        ),
      ),
    );
  }
}
