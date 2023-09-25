import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/container_limit.dart';
import 'package:flutter_app_erp/widgets/form_signup_request.dart';

class SignupScreenDesktop extends StatelessWidget {
  const SignupScreenDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ContainerLimit(
        maxWidth: 1200,
        minHeight: 600,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: ImageContain(),
              ),
              SizedBox(
                width: 450,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: FormSignupRequest(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageContain extends StatelessWidget {
  const ImageContain({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
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
    );
  }
}
