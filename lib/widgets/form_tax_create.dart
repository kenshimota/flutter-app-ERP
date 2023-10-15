import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_erp/widgets/form_tax.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:flutter_app_erp/core/http/taxes/create_tax.dart';

class FormTaxCreate extends StatelessWidget {
  final void Function()? onAfterSave;

  const FormTaxCreate({super.key, this.onAfterSave});

  void onSubmitRequest({
    required BuildContext context,
    required Map<String, dynamic> params,
  }) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final String? token = authProvider.getToken();


    await createTax(
      token: token,
      name: params["name"],
      percentage: params["percentage"],
    );

    if (!context.mounted) {
      return;
    }

    onAfterSave!();
  }

  @override
  Widget build(BuildContext context) {
    return FormTax(
      onRequest: (Map<String, dynamic> params) async => onSubmitRequest(
        context: context,
        params: params,
      ),
    );
  }
}
