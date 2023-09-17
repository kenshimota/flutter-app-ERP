import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  onPressed() {
    Logger logger = Logger();
    logger.w("test: fluytter");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("app"),
        // backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
          child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Signup - Registrarse"),
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
