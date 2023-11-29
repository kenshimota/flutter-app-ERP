import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:flutter_app_erp/core/exception/auth_errors.dart';
import 'package:flutter_app_erp/core/exception/form_errors.dart';
import 'package:flutter_app_erp/core/http/inventories/update_inventory.dart';
import 'package:flutter_app_erp/widgets/inventories/form_inventory.dart';

class FormInventoryUpdate extends StatefulWidget {
  final int id;
  final int? stockDefault;
  final String? observationsDefault;
  final void Function()? onAfterSave;

  const FormInventoryUpdate(
      {super.key,
      required this.id,
      this.onAfterSave,
      this.stockDefault,
      this.observationsDefault});

  @override
  State<FormInventoryUpdate> createState() => _FormInventoryUpdateState();
}

class _FormInventoryUpdateState extends State<FormInventoryUpdate> {
  FormErrors errors = FormErrors(map: {});

  void onSubmitRequest({
    required BuildContext context,
    required Map<String, dynamic> params,
  }) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final String? token = authProvider.getToken();

    try {
      await updateInventory(
        id: widget.id,
        token: token as String,
        stock: params["stock"],
        observations: params["observations"],
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
    return FormInventory(
      isEdit: true,
      stockDefault: widget.stockDefault,
      observationsDefault: widget.observationsDefault,
      errors: errors,
      onRequest: (Map<String, dynamic> params) async => onSubmitRequest(
        context: context,
        params: params,
      ),
    );
  }
}
