import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/constants/roles_constants.dart';
import 'package:flutter_app_erp/core/http/customers/get_customer.dart';
import 'package:flutter_app_erp/core/response/customers/customers_response.dart';
import 'package:flutter_app_erp/core/response/users/user_response.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:flutter_app_erp/widgets/circular_button.dart';
import 'package:flutter_app_erp/widgets/orders/dialog_new_order.dart';
import 'package:provider/provider.dart';

Map<String, bool> allowCreatOrders = {
  RolesConstants.manager(): true,
  RolesConstants.salePerson(): true,
};

class ButtonNewOrder extends StatelessWidget {
  final void Function()? onSave;
  final String token;

  const ButtonNewOrder({
    super.key,
    this.onSave,
    required this.token,
  });

  onNewOrder(BuildContext context, String token) async {
    CustomersResponse? customer;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final UserResponse current = authProvider.getCurrentUser() as UserResponse;

    if (allowCreatOrders[current.roleId] == null) {
      customer = await getCustomer(token: token, id: current.customerId);
    }

    if (!context.mounted) {
      return;
    }
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialogNewOrder(
          token: token,
          onSave: onSave,
          defaultCustomer: customer,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CircularButton(
      icon: const Icon(
        Icons.add,
        color: Colors.white,
      ),
      context: context,
      onPressed: () => onNewOrder(context, token),
    );
  }
}
