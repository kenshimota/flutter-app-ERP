import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/form_signin.dart';
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
        child: ContainerBodyApp(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10.0, top: 100.0),
              child: const FormSignin(),
            ),
          ],
        ),
      ),
    );
  }
}

// El container centrado, el que va a llevar a email y password
class ContainerBodyApp extends StatelessWidget {
  // final Widget? child;
  final List<Widget>? children;
  final Color color = Colors.white;

  const ContainerBodyApp({super.key, this.children});

  @override
  Widget build(BuildContext context) {
    final List<Widget>? children = this.children;
    final Color color = this.color;

    return Flexible(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: FractionallySizedBox(
            // heightFactor: 1,
            widthFactor: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: color,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: children ?? [],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
