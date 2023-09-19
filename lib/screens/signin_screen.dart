import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/layourt_twice_builder.dart';
import 'package:logger/logger.dart';
import 'package:flutter_app_erp/widgets/signin_screen_desktop.dart';
import 'package:flutter_app_erp/widgets/signin_screen_mobile.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  onPressed() {
    Logger logger = Logger();
    logger.w("test: fluytter");
  }

  @override
  Widget build(BuildContext context) {
    return const LayourtTwiceBuilder(
      mobile: SigninScreenMobile(),
      desktop: SigninScreenDesktop(),
    );
  }
}
