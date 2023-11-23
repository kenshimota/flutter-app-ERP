import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_app_erp/core/exception/form_errors.dart';
import 'package:flutter_app_erp/core/http/reset_password/update_password_forgot.dart';
import 'package:flutter_app_erp/core/response/users/user_response.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:flutter_app_erp/widgets/input_password.dart';
import 'package:flutter_app_erp/widgets/reset_password/input_code_password.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app_erp/widgets/typography.dart';
import 'package:flutter_app_erp/widgets/form_control.dart';
import 'package:flutter_app_erp/widgets/elevated_button_future.dart';
import 'package:provider/provider.dart';

class FormUpdatePassword extends StatefulWidget {
  final String email;
  final Future<void> Function()? onSended;

  const FormUpdatePassword({
    super.key,
    required this.email,
    this.onSended,
  });

  @override
  State<FormUpdatePassword> createState() => _FormUpdatePassword();
}

class _FormUpdatePassword extends State<FormUpdatePassword> {
  Future? future;
  FormErrors? errors;
  final TextEditingController _code = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _password = TextEditingController();

  Future<void> onRequest(
    Map<String, dynamic> params,
    BuildContext context,
  ) async {
    bool success = false;

    try {
      success = await updatePasswordForgot(
        email: widget.email,
        password: params["password"],
        code: params["code"],
      );
    } on FormErrors catch (e) {
      setState(() {
        errors = e;
      });
    } on Exception catch (e) {
      showError(context, e);
    } catch (e) {
      showError(context, Exception("Verifique su conexión"));
    }

    if (success && context.mounted) {
      GoRouter.of(context).go("/singin");
    }
  }

  void showError(BuildContext context, Object? error) {
    final String message = error.toString().split(":")[1];

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.error,
        content: Text(message),
      ),
    );
  }

  onSubmit(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return null;
    }

    setState(() {
      future = onRequest(
        {"code": _code.text, "password": _password.text},
        context,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Row(
        children: [
          Expanded(
            child: Column(children: [
              const FormControl(
                child: Center(
                  child: Icon(
                    Icons.lock_reset,
                    size: 80.0,
                  ),
                ),
              ),
              const FormControl(
                child: TypographyApp(
                  text: "Recuperar Contraseña",
                  variant: "h4",
                  color: "primary",
                ),
              ),
              const FormControl(
                child: TypographyApp(
                  text:
                      "Se ha enviado un correo electronico, con un codigo de confirmación. debe ingresarlo para poder actualizar su contraseña",
                  variant: "body1",
                ),
              ),
              FormControl(
                child: InputCodePassword(
                  future: future,
                  controller: _code,
                  errorText: errors?.getValue("reset_token"),
                ),
              ),
              FormControl(
                child: InputPassword(
                  future: future,
                  controller: _password,
                  errorText: errors?.getValue("password"),
                ),
              ),
              FormControl(
                child: ElevatedButtonFuture(
                  onPressed: () => onSubmit(context),
                  future: future,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50), // NEW
                  ),
                  child: const Text('Actualizar Contraseña'),
                ),
              ),
              const FormControl(
                child: _TextAboutToGoToSignin(),
              )
            ]),
          ),
        ],
      ),
    );
  }
}

class _TextAboutToGoToSignin extends StatelessWidget {
  const _TextAboutToGoToSignin({super.key});

  onPressed(BuildContext context) {
    context.go("/signin");
  }

  @override
  Widget build(BuildContext context) {
    Color? color = Theme.of(context).colorScheme.surface;

    return RichText(
      text: TextSpan(
        text: '¿Recordaste tu contraseña? ',
        style: const TextStyle(color: Colors.black, fontSize: 18),
        children: [
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () => onPressed(context),
            text: 'Iniciar Sesión',
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
