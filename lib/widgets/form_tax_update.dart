import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/exception/auth_errors.dart';
import 'package:flutter_app_erp/core/http/taxes/update_tax.dart';
import 'package:flutter_app_erp/core/response/taxes/taxes_response.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_erp/widgets/form_tax.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';

class FormTaxUpdate extends StatelessWidget {
  final TaxesResponse tax;
  final void Function()? onAfterSave;

  const FormTaxUpdate({super.key, this.onAfterSave, required this.tax});

  void onSubmitRequest({
    required BuildContext context,
    required Map<String, dynamic> params,
  }) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      final String? token = authProvider.getToken();

      await updateTax(
        token: token,
        taxId: tax.id,
        name: params["name"],
        percentage: params["percentage"],
      );

      if (!context.mounted) {
        return;
      }

      onAfterSave!();
    } on AuthErrors {
      authProvider.signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormTax(
      nameDefault: tax.name,
      percentageDefault: "${(tax.percentage * 100)}",
      onRequest: (Map<String, dynamic> params) async => onSubmitRequest(
        context: context,
        params: params,
      ),
    );
  }
}
