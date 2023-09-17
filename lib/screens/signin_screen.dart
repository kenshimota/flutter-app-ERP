import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/layourt_twice_builder.dart';
import 'package:logger/logger.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  onPressed() {
    Logger logger = Logger();
    logger.w("test: fluytter");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          const Padding(
              padding: EdgeInsets.all(8.0),
              child: LayourtTwiceBuilder(
                mobile: Text("Estamos en el mobile"),
                desktop: Text("estamos en computador"),
              )),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Signin - Iniciar Sesión"),
          ),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: OutlinedButton(
                onPressed: onPressed,
                child: const Text("outlined"),
              )),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: onPressed,
                child: const Text("elevation"),
              )),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextButton(
                onPressed: onPressed,
                child: const Text("text button"),
              )),
        ],
      )),
    );
  }
}
