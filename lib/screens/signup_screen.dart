import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/container_limit.dart';
import 'package:flutter_app_erp/widgets/form_signup_request.dart';
import 'package:flutter_app_erp/widgets/layourt_twice_builder.dart';
import 'package:flutter_app_erp/widgets/signup_screen_desktop.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LayourtTwiceBuilder(
        mobile: ContainerLimit(
          maxWidth: 450,
          child: FormSignupRequest(),
        ),
        desktop: SignupScreenDesktop(),
      ),
    );
  }
}
