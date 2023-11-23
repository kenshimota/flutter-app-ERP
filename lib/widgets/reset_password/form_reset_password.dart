import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/reset_password/form_give_code.dart';
import 'package:flutter_app_erp/widgets/reset_password/form_update_password.dart';

class FormResetPassword extends StatefulWidget {
  const FormResetPassword({
    super.key,
  });

  @override
  State<FormResetPassword> createState() => _FormResetPassword();
}

class _FormResetPassword extends State<FormResetPassword> {
  String? email;

  Future<void> onSended(String newEmail) async {
    setState(() {
      email = newEmail;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (email == null) {
      return FormGiveCodePassword(
        onSended: onSended,
      );
    }

    return FormUpdatePassword(
      email: email as String,
    );
  }
}
