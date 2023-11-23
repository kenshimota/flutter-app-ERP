import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/http/products/update_product.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:flutter_app_erp/core/exception/auth_errors.dart';
import 'package:flutter_app_erp/core/exception/form_errors.dart';
import 'package:flutter_app_erp/widgets/products/form_product.dart';

class FormProductUpdate extends StatefulWidget {
  final int id;
  final String? nameDefault;
  final String? codeDefault;
  final String? barCodeDefault;
  final void Function()? onAfterSave;

  const FormProductUpdate({
    super.key,
    required this.id,
    this.onAfterSave,
    this.nameDefault,
    this.codeDefault,
    this.barCodeDefault,
  });

  @override
  State<FormProductUpdate> createState() => _FormProductUpdateState();
}

class _FormProductUpdateState extends State<FormProductUpdate> {
  FormErrors errors = FormErrors(map: {});

  void onSubmitRequest({
    required BuildContext context,
    required Map<String, dynamic> params,
  }) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final String? token = authProvider.getToken();

    try {
      await updateProduct(
        id: widget.id,
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
      nameDefault: widget.nameDefault,
      codeDefault: widget.codeDefault,
      barCodeDefault: widget.barCodeDefault,
      errors: errors,
      onRequest: (Map<String, dynamic> params) async => onSubmitRequest(
        context: context,
        params: params,
      ),
    );
  }
}
