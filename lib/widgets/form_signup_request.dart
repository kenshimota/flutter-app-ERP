import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/exception/form_errors.dart';
import 'package:flutter_app_erp/widgets/form_signup.dart';
import 'package:flutter_app_erp/core/http/users/create_user.dart';
import 'package:flutter_app_erp/core/response/users/user_response.dart';
import 'package:go_router/go_router.dart';

class FormSignupRequest extends StatefulWidget {
  const FormSignupRequest({super.key});

  @override
  State<FormSignupRequest> createState() => _FormSignupRequestState();
}

class _FormSignupRequestState extends State<FormSignupRequest> {
  Future<UserResponse?>? _futureSession;
  FormErrors errors = FormErrors(map: {});

  Future<UserResponse?> onRequest(
    Map<String, dynamic> params,
    BuildContext context,
  ) async {
    UserResponse? response;

    try {
      response = await createUser(
        username: params["username"],
        password: params["password"],
        firstName: params["first_name"],
        lastName: params["last_name"],
        identityDocument: 123123123123,
        email: params["email"],
      );
    } on Exception catch (e) {
      showError(context, e);
    } on FormErrors catch (e) {
      setState(() {
        errors = e;
      });
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
