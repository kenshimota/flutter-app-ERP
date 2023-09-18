import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/form_signin.dart';
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
    return const LayourtTwiceBuilder(
      mobile: SigninScreenMobile(),
      desktop: SigninScreenDesktop(),
    );
  }
}

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

class SigninScreenMobile extends StatelessWidget {
  const SigninScreenMobile({super.key});

  onPressed() {
    Logger logger = Logger();
    logger.w("test: fluytter");
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ContainerLimit(
        maxWidth: 500,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: FormSignin(),
        ),
      ),
    );
  }
}

class ContainerLimit extends StatelessWidget {
  final double maxWidth;
  final double maxHeight;
  final double minWidth;
  final double minHeight;
  final Color? color;
  final Widget? child;

  const ContainerLimit({
    super.key,
    this.maxWidth = double.infinity,
    this.maxHeight = double.infinity,
    this.minWidth = 0,
    this.minHeight = 0,
    this.child,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      child: OverflowBox(
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        minHeight: minHeight,
        minWidth: minWidth,
        child: FractionallySizedBox(
          widthFactor: 1,
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
