import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/exception/auth_errors.dart';
import 'package:flutter_app_erp/core/exception/form_errors.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_erp/widgets/form_tax.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:flutter_app_erp/core/http/taxes/create_tax.dart';

class FormTaxCreate extends StatefulWidget {
  final void Function()? onAfterSave;
  const FormTaxCreate({super.key, this.onAfterSave});

  @override
  State<FormTaxCreate> createState() => _FormTaxCreateState();
}

class _FormTaxCreateState extends State<FormTaxCreate> {
  FormErrors errors = FormErrors(map: {});

  void onSubmitRequest({
    required BuildContext context,
    required Map<String, dynamic> params,
  }) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final String? token = authProvider.getToken();

    try {
      await createTax(
        token: token,
        name: params["name"],
        percentage: params["percentage"],
      );

      if (!context.mounted) {
        return;
      }

      widget.onAfterSave!();
    } on AuthErrors {
      authProvider.signOut();
    } on FormErrors catch (e) {
      setState(() {
        errors = e;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormTax(
      errors: errors,
      onRequest: (Map<String, dynamic> params) async => onSubmitRequest(
        context: context,
        params: params,
      ),
    );
  }
}
