import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/container_limit.dart';
import 'package:flutter_app_erp/widgets/reset_password/form_reset_password.dart';

class ResetPasswordMobile extends StatelessWidget {
  const ResetPasswordMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ContainerLimit(
        maxWidth: 500,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: FormResetPassword(),
        ),
      ),
    );
  }
}
