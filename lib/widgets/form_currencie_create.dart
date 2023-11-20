import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/exception/form_errors.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_erp/widgets/form_currencies.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import "package:flutter_app_erp/core/exception/auth_errors.dart";
import 'package:flutter_app_erp/core/http/currencies/create_currencie.dart';

class FormCurrencieCreate extends StatefulWidget {
  final void Function()? onAfterSave;
  const FormCurrencieCreate({super.key, this.onAfterSave});

  @override
  State<FormCurrencieCreate> createState() => _FormCurrencieCreateState();
}

class _FormCurrencieCreateState extends State<FormCurrencieCreate> {
  FormErrors errors = FormErrors(map: {});

  void onSubmitRequest({
    required BuildContext context,
    required Map<String, dynamic> params,
  }) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final String? token = authProvider.getToken();

    try {
      await createCurrencies(
        token: token,
        name: params["name"],
        symbol: params["symbol"],
        code: params["code"],
        exchangeRate: params["exchangeRate"],
      );

      if (!context.mounted) {
        return;
      }

      widget.onAfterSave!();
    } on FormErrors catch (e) {
      setState(() {
        errors = e;
      });
    } on AuthErrors {
      authProvider.signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormCurrencie(
      errors: errors,
      onRequest: (Map<String, dynamic> params) async => onSubmitRequest(
        context: context,
        params: params,
      ),
    );
  }
}
