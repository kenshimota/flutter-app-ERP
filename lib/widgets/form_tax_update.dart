import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/exception/auth_errors.dart';
import 'package:flutter_app_erp/core/http/taxes/update_tax.dart';
import 'package:flutter_app_erp/core/response/taxes/taxes_response.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_erp/widgets/form_tax.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:flutter_app_erp/core/exception/form_errors.dart';

class FormTaxUpdate extends StatefulWidget {
  final TaxesResponse tax;
  final String? nameDefault;
  final double? percentageDefault;
  final void Function()? onAfterSave;

  const FormTaxUpdate({
    super.key, 
    required this.tax,
    this.onAfterSave,
    this.nameDefault,
    this.percentageDefault
    });

  @override
  State<FormTaxUpdate> createState() => _FormTaxUpdateState();
}

class _FormTaxUpdateState extends State<FormTaxUpdate>{
  FormErrors errors = FormErrors(map: {});

  void onSubmitRequest({
    required BuildContext context,
    required Map<String, dynamic> params,
  }) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final String? token = authProvider.getToken();

    try {
      await updateTax(
        token: token,
        taxId: widget.tax.id,
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
      nameDefault: widget.tax.name,
      percentageDefault: (widget.tax.percentage * 10000 / 100).toStringAsFixed(2),
      errors: errors,
      onRequest: (Map<String, dynamic> params) async => onSubmitRequest(
        context: context,
        params: params,
      ),
    );
  }
}
