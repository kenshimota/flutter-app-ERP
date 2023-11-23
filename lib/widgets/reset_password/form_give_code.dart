import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app_erp/widgets/typography.dart';
import 'package:flutter_app_erp/widgets/input_email.dart';
import 'package:flutter_app_erp/widgets/form_control.dart';
import 'package:flutter_app_erp/widgets/elevated_button_future.dart';
import 'package:flutter_app_erp/core/http/reset_password/create_code_password.dart';

class FormGiveCodePassword extends StatefulWidget {
  final Future<void> Function(String email)? onSended;

  const FormGiveCodePassword({
    super.key,
    this.onSended,
  });

  @override
  State<FormGiveCodePassword> createState() => _FormGiveCodePassword();
}

class _FormGiveCodePassword extends State<FormGiveCodePassword> {
  Future? future;
  final TextEditingController _email = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> onRequest(
    Map<String, dynamic> params,
    BuildContext context,
  ) async {
    bool success = false;

    try {
      success = await createCodePassword(email: params["email"]);
    } on Exception catch (e) {
      showError(context, e);
    } catch (e) {
      showError(context, Exception("Verifique su conexión"));
    }

    if (success && context.mounted) {
      widget.onSended!(_email.text);
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
      future = onRequest({"email": _email.text}, context);
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
                    Icons.lock_clock,
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
              FormControl(
                child: InputEmail(
                  future: future,
                  controller: _email,
                ),
              ),
              FormControl(
                child: ElevatedButtonFuture(
                  onPressed: () => onSubmit(context),
                  future: future,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50), // NEW
                  ),
                  child: const Text('Solicitar Codigo'),
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
