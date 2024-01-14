import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/elevated_button_future.dart';
import 'package:flutter_app_erp/widgets/input_user_name.dart';

import 'package:go_router/go_router.dart';
import 'package:flutter_app_erp/widgets/typography.dart';
import 'package:flutter_app_erp/widgets/form_control.dart';
import 'package:flutter_app_erp/widgets/input_password.dart';

class FormSignin extends StatefulWidget {
  final Future? future;
  final void Function(Map<String, dynamic>) onSubmit;

  const FormSignin({super.key, required this.onSubmit, this.future});

  @override
  State<FormSignin> createState() => _FormSigninState();
}

class _FormSigninState extends State<FormSignin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  onSubmit() {
    if (!_formKey.currentState!.validate()) {
      return null;
    }

    widget.onSubmit({"username": _username.text, "password": _password.text});
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
                    size: 80.0,
                  ),
                ))
              ]),
              Row(children: [
                Expanded(
                    child: Center(
                  child: TypographyApp(
                    text: "Iniciar Sesión",
                    variant: "h5",
                    color: "primary",
                  ),
                ))
              ]),
            ]),
          ),
          FormControl(
            child: InputUserName(
              controller: _username,
              future: widget.future,
            ),
          ),
          FormControl(
            child: InputPassword(
              controller: _password,
              future: widget.future,
            ),
          ),
          FormControl(
            child: ElevatedButtonFuture(
              onPressed: onSubmit,
              future: widget.future,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50), // NEW
              ),
              child: const Text('Iniciar sesion'),
            ),
          ),
          const FormControl(
            child: Column(
              children: [
                Row(children: [
                  Expanded(
                    child: Center(
                      child: _TextAboutToGoToReset(),
                    ),
                  ),
                ]),
                SizedBox(height: 20),
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

class _TextAboutToGoToReset extends StatelessWidget {
  const _TextAboutToGoToReset({super.key});

  onPressed(BuildContext context) {
    context.go("/reset_password");
  }

  @override
  Widget build(BuildContext context) {
    Color? color = Theme.of(context).colorScheme.surface;

    return RichText(
      text: TextSpan(
        recognizer: TapGestureRecognizer()..onTap = () => onPressed(context),
        text: '¿Has olvidado tu contraseña?',
        style: TextStyle(
          color: color,
          fontSize: 18,
        ),
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
    final Brightness currentBrightness = Theme.of(context).brightness;
    Color? color = Theme.of(context).colorScheme.surface;

    return RichText(
      text: TextSpan(
        text: '¿No tienes una cuenta? ',
        style: TextStyle(
            color: currentBrightness == Brightness.dark
                ? const Color(0xf9f9f9f9)
                : Colors.black,
            fontSize: 18),
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
