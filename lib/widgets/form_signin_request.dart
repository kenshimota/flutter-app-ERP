import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app_erp/widgets/form_signin.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:flutter_app_erp/core/response/users/user_response.dart';

class FormSigninRequest extends StatefulWidget {
  const FormSigninRequest({super.key});

  @override
  State<FormSigninRequest> createState() => _FormSigninRequestState();
}

class _FormSigninRequestState extends State<FormSigninRequest> {
  Future<UserResponse?>? _futureSession;

  Future<UserResponse?> onRequest(
      Map<String, dynamic> params, BuildContext context) async {
    UserResponse? response;

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      await authProvider.signIn(
        username: params["username"],
        password: params["password"],
      );
    } on Exception catch (e) {
      showError(context, e);
    } catch (e) {
      showError(context, Exception("Verifique su conexión"));
    }

    if (context.mounted) {
      GoRouter.of(context).go("/");
    }

    return response;
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
    return FormSignin(
      future: _futureSession,
      onSubmit: (Map<String, dynamic> params) {
        setState(() {
          _futureSession = onRequest(params, context);
        });
      },
    );
  }
}
