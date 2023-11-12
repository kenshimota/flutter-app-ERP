import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app_erp/widgets/form_signup.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:flutter_app_erp/core/exception/form_errors.dart';

class FormSignupRequest extends StatefulWidget {
  const FormSignupRequest({super.key});

  @override
  State<FormSignupRequest> createState() => _FormSignupRequestState();
}

class _FormSignupRequestState extends State<FormSignupRequest> {
  Future? _futureSession;
  FormErrors errors = FormErrors(map: {});

  Future<void> onRequest(
    Map<String, dynamic> params,
    BuildContext context,
  ) async {
    bool success = false;

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      await authProvider.signUp(
        username: params["username"],
        password: params["password"],
        firstName: params["first_name"],
        lastName: params["last_name"],
        identityDocument: int.parse(params["identity_document"]),
        email: params["email"],
      );

      success = true;
    } on Exception catch (e) {
      showError(context, e);
    } on FormErrors catch (e) {
      setState(() {
        errors = e;
      });
    } catch (e) {
      showError(context, Exception("Verifique su conexión"));
    }

    if (success && context.mounted) {
      GoRouter.of(context).go("/");
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

  @override
  Widget build(BuildContext context) {
    return FormSignup(
      errors: errors,
      future: _futureSession,
      onSubmit: (Map<String, dynamic> params) {
        setState(() {
          _futureSession = onRequest(params, context);
        });
      },
    );
  }
}
