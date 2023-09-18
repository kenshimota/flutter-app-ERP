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
    return const Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Center(
                    child: ContainerLimit(
                      maxHeight: 400,
                      maxWidth: 350,
                      child: FormSignin(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContainerLimit extends StatelessWidget {
  final double maxWidth;
  final double maxHeight;
  final Color? color;
  final Widget? child;

  const ContainerLimit({
    super.key,
    required this.maxWidth,
    required this.maxHeight,
    this.child,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          color: color,
          child: child,
        ),
      ),
    );
  }
}
