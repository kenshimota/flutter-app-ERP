import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/form_signin.dart';
import 'package:logger/logger.dart';
import 'package:flutter_app_erp/widgets/container_limit.dart';

class SigninScreenDesktop extends StatelessWidget {
  const SigninScreenDesktop({super.key});

  onPressed() {
    Logger logger = Logger();
    logger.w("test: fluytter");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContainerLimit(
        maxWidth: 1024,
        minHeight: 600,
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
                      image: NetworkImage(
                          "https://interseguridad.org/wp-content/uploads/2018/12/contadorpublico.jpeg"),
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
                child: FormSignin(),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
