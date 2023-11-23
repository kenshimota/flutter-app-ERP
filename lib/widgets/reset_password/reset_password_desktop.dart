import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/container_limit.dart';
import 'package:flutter_app_erp/widgets/reset_password/form_reset_password.dart';

class ResetPasswordDesktop extends StatelessWidget {
  const ResetPasswordDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContainerLimit(
        maxWidth: 1024,
        minHeight: 500,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                      image: AssetImage('assets/img/first-image.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 350,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: FormResetPassword(),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
