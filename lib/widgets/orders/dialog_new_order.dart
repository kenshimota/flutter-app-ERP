import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/response/customers/customers_response.dart';
import 'package:flutter_app_erp/widgets/alert_dialog_app.dart';
import 'package:flutter_app_erp/widgets/orders/form_customer.dart';
import 'package:flutter_app_erp/widgets/orders/form_orders.dart';
import 'package:flutter_app_erp/widgets/orders/form_orders_search.dart';
import 'package:flutter_app_erp/widgets/typography.dart';

class AlertDialogNewOrder extends StatefulWidget {
  final void Function()? onSave;
  final String token;

  const AlertDialogNewOrder({
    super.key,
    this.onSave,
    required this.token,
  });

  @override
  // ignore: library_private_types_in_public_api
  _AlertDialogNewOrder createState() => _AlertDialogNewOrder();
}

class _AlertDialogNewOrder extends State<AlertDialogNewOrder> {
  bool? isFound;
  CustomersResponse? customer;

  getCustomer(CustomersResponse? client) {
    setState(() {
      isFound = client != null;
      customer = client;
    });
  }

  Widget buildContent(BuildContext context) {
    if (isFound == null) {
      return FormOrdersSearch(
        token: widget.token,
        getCustomer: getCustomer,
      );
    }

    if (isFound == true) {
      return FormCreateOrder(
        token: widget.token,
        customer: customer as CustomersResponse,
        onSave: onSave,
      );
    }

    return FormCustomer(
      token: widget.token,
      onSave: getCustomer,
    );
  }

  Widget buildTitle(BuildContext context) {
    if (isFound == null) {
      return const TypographyApp(
        text: "Buscar Cliente", 
        variant: "h3"
      );
    } else if (isFound == true) {
      return const TypographyApp(
        text: "Crear pedido", 
        variant: "h3"
      );
    }
    return const TypographyApp(
      text: "Crear cliente",
      variant: "h3",
    );
  }

  double buildHeight() {
    if (isFound == null) {
      return 340;
    }

    if (isFound == true) {
      return 220;
    }

    return 550;
  }

  void onSave() {
    Navigator.of(context).pop();
    widget.onSave!();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialogApp(
      maxHeight: buildHeight(),
      title: Center(
        child: buildTitle(context),
      ),
      content: [
        Expanded(
          child: buildContent(context),
        ),
      ],
    );
  }
}
