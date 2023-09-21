import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/form_signin.dart';
import 'package:flutter_app_erp/core/http/sessions/create_session.dart';
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
      response = await createSession(params["username"], params["password"]);
    } on Exception catch (e) {
      showError(context, e);
    } catch (e) {
      showError(context, Exception("Chequee su conexión"));
    }

    return response;
  }

  @override
  Widget build(BuildContext context) {
    if (_futureSession == null) {
      return buildForm(context);
    }

    return buildFuture(context);
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

  Widget buildFuture(BuildContext context) {
    return FutureBuilder<UserResponse?>(
      future: _futureSession,
      builder: (ctx, snapshot) {
        final bool loading =
            snapshot.connectionState == ConnectionState.waiting;

        return buildForm(context, loading: loading);
      },
    );
  }

  Widget buildForm(BuildContext context, {bool loading = false}) {
    return FormSignin(
      loading: loading,
      onSubmit: (Map<String, dynamic> params) {
        setState(() {
          _futureSession = onRequest(params, context);
        });
      },
    );
  }
}
