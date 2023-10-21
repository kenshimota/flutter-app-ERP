import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_erp/widgets/form_warehouse.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:flutter_app_erp/core/http/warehouse/create_warehouse.dart';

class FormWarehouseCreate extends StatelessWidget {
  final void Function()? onAfterSave;

  const FormWarehouseCreate({super.key, this.onAfterSave });

  void onSubmitRequest({
    required BuildContext context,
    required Map<String, dynamic> params,
  }) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final String? token = authProvider.getToken();

    await createWarehouse(
      token: token,
      name: params["name"],
      address: params["address"],
    );

    if (!context.mounted) {
      return;
    }

    onAfterSave!();
  }

  @override
  Widget build(BuildContext context) {
    return FormWarehouse(
      onRequest: (Map<String, dynamic> params) async => onSubmitRequest(
        context: context,
        params: params,
      ),
    );
  }
}

