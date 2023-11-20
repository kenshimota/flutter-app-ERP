import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/exception/auth_errors.dart';
import 'package:flutter_app_erp/core/http/warehouse/update_warehouse.dart';
import 'package:flutter_app_erp/core/response/warehouse/warehouse_response.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_erp/widgets/form_warehouse.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';

class FormWarehouseUpdate extends StatelessWidget {
  final WarehouseResponse ware;
  final void Function()? onAfterSave;

  const FormWarehouseUpdate({super.key, this.onAfterSave, required this.ware});

  void onSubmitRequest({
    required BuildContext context,
    required Map<String, dynamic> params,
  }) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      final String? token = authProvider.getToken();

      await updateWarehouse(
        token: token,
        wareId: ware.id,
        name: params["name"],
        address: params["address"],
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
    return FormWarehouse(
      nameDefault: ware.name,
      addressDefault: ware.address,
      onRequest: (Map<String, dynamic> params) async => onSubmitRequest(
        context: context,
        params: params,
      ),
    );
  }
}
