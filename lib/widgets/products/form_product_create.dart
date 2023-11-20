import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:flutter_app_erp/core/exception/auth_errors.dart';
import 'package:flutter_app_erp/core/exception/form_errors.dart';
import 'package:flutter_app_erp/widgets/products/form_product.dart';
import 'package:flutter_app_erp/core/http/products/create_product.dart';

class FormProductCreate extends StatefulWidget {
  final void Function()? onAfterSave;
  const FormProductCreate({super.key, this.onAfterSave});

  @override
  State<FormProductCreate> createState() => _FormProductCreateState();
}

class _FormProductCreateState extends State<FormProductCreate> {
  FormErrors errors = FormErrors(map: {});

  void onSubmitRequest({
    required BuildContext context,
    required Map<String, dynamic> params,
  }) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final String? token = authProvider.getToken();

    try {
      await createProduct(
        token: token,
        name: params["name"],
        code: params["code"],
        barCode: params["bar_code"],
        taxId: params["tax_id"],
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
    return FormProduct(
      errors: errors,
      onRequest: (Map<String, dynamic> params) async => onSubmitRequest(
        context: context,
        params: params,
      ),
    );
  }
}
