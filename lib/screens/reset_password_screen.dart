import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/layourt_twice_builder.dart';
import 'package:flutter_app_erp/widgets/reset_password/reset_password_desktop.dart';
import 'package:flutter_app_erp/widgets/reset_password/reset_password_mobile.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LayourtTwiceBuilder(
      desktop: ResetPasswordDesktop(),
      mobile: ResetPasswordMobile(),
    );
  }
}
