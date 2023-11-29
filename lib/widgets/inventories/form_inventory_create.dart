import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/http/inventories/create_inventory.dart';
import 'package:flutter_app_erp/widgets/inventories/form_inventory.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:flutter_app_erp/core/exception/auth_errors.dart';
import 'package:flutter_app_erp/core/exception/form_errors.dart';

class FormInventoryCreate extends StatefulWidget {
  final void Function()? onAfterSave;
  const FormInventoryCreate({super.key, this.onAfterSave});

  @override
  State<FormInventoryCreate> createState() => _FormInventoryCreateState();
}

class _FormInventoryCreateState extends State<FormInventoryCreate> {
  FormErrors errors = FormErrors(map: {});

  void onSubmitRequest({
    required BuildContext context,
    required Map<String, dynamic> params,
  }) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final String? token = authProvider.getToken();

    try {
      await createInventory(
        token: token ?? "",
        stock: params["stock"],
        productId: params["product_id"],
        warehouseId: params["warehouse_id"],
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
      errors: errors,
      onRequest: (Map<String, dynamic> params) async => onSubmitRequest(
        context: context,
        params: params,
      ),
    );
  }
}
