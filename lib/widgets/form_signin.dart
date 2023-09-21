import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:flutter_app_erp/widgets/typography.dart';
import 'package:flutter_app_erp/widgets/input_email.dart';
import 'package:flutter_app_erp/widgets/form_control.dart';
import 'package:flutter_app_erp/widgets/input_password.dart';

class FormSignin extends StatefulWidget {
  final bool? loading;
  final void Function(Map<String, dynamic>) onSubmit;

  const FormSignin({super.key, required this.onSubmit, this.loading});

  @override
  State<FormSignin> createState() => _FormSigninState();
}

class _FormSigninState extends State<FormSignin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  onSubmit() {
    if (!_formKey.currentState!.validate()) {
      return null;
    }

    widget.onSubmit({"username": _email.text, "password": _password.text});
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
          FormControl(
            child: InputEmail(
              controller: _email,
              isRequired: true,
            ),
          ),
          FormControl(
            child: InputPassword(controller: _password),
          ),
          FormControl(
            child: ElevatedButton(
              onPressed: widget.loading! ? null : onSubmit,
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
                        child: _TextAboutToGoToSignup(),
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

class _TextAboutToGoToSignup extends StatelessWidget {
  const _TextAboutToGoToSignup({super.key});

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
