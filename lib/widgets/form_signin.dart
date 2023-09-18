import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app_erp/widgets/typography.dart';
import 'package:flutter_app_erp/widgets/input_email.dart';
import 'package:flutter_app_erp/widgets/form_control.dart';
import 'package:flutter_app_erp/widgets/input_password.dart';
import 'package:go_router/go_router.dart';

class FormSignin extends StatefulWidget {
  const FormSignin({super.key});

  @override
  State<FormSignin> createState() => _FormSigninState();
}

class TextAboutToGoToSignup extends StatelessWidget {
  const TextAboutToGoToSignup({super.key});

  onPressed(BuildContext context) {
    context.go("/signup");
  }

  @override
  Widget build(BuildContext context) {
    Color? color = Theme.of(context).colorScheme.surface;

    return RichText(
      text: TextSpan(
        text: '¿No tienes una cuenta? ',
        style: const TextStyle(color: Colors.black, fontSize: 18),
        children: [
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () => onPressed(context),
            text: 'Registrate',
            style: TextStyle(
              color: color,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}

class _FormSigninState extends State<FormSignin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  onSubmit() {
    if (_formKey.currentState!.validate()) {
      debugPrint('Iniciar sesion');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const FormControl(
            child: Column(children: [
              Row(children: [
                Expanded(
                    child: Center(
                  child: Icon(
                    Icons.person,
                    color: Colors.purple,
                    size: 80.0,
                  ),
                ))
              ]),
              Row(children: [
                Expanded(
                    child: Center(
                  child: TypographyApp(
                    text: "Iniciar Sesión",
                    variant: "h4",
                  ),
                ))
              ]),
            ]),
          ),
          const FormControl(
            child: InputEmail(
              isRequired: true,
            ),
          ),
          const FormControl(
            child: InputPassword(),
          ),
          FormControl(
            child: ElevatedButton(
              onPressed: onSubmit,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50), // NEW
              ),
              child: const Text('Iniciar sesion'),
            ),
          ),
          const FormControl(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: TextAboutToGoToSignup(),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
