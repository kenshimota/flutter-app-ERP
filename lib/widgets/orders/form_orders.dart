import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/exception/auth_errors.dart';
import 'package:flutter_app_erp/core/exception/form_errors.dart';
import 'package:flutter_app_erp/core/http/orders/create_order.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:flutter_app_erp/widgets/elevated_button_future.dart';
import 'package:flutter_app_erp/widgets/form_control.dart';
import 'package:flutter_app_erp/widgets/typography.dart';
import 'package:flutter_app_erp/core/response/customers/customers_response.dart';
import 'package:flutter_app_erp/widgets/autocomplete/autocomplete_currencies.dart';
import 'package:provider/provider.dart';

class FormCreateOrder extends StatefulWidget {
  final String token;
  final void Function()? onSave;
  final CustomersResponse customer;

  const FormCreateOrder({
    super.key,
    required this.token,
    required this.customer,
    this.onSave
  });

  @override
  State<FormCreateOrder> createState() => _FormCreateOrder();
}

class _FormCreateOrder extends State<FormCreateOrder> {
  int? currencyId;
  Future? future;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  FormErrors errors = FormErrors(map: {});

  onRequest() async{
  final authProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      await createOrders(
      token: widget.token,
      customerId: widget.customer.id,
      currencyId: currencyId as int,
      );


      widget.onSave!();
    } on AuthErrors {
      authProvider.signOut();
    } on FormErrors catch (e) {
      setState(() {
        errors = e;
      });
    }
  }

  onSubmit() {
    if (!_formkey.currentState!.validate()) {
      return null;
    }

    setState(() {
      future = onRequest();
    });


  }

  onSelect(Map<String, dynamic>? currency) {
    setState(() {
      int? value = currency == null ? null : currency["id"];
      currencyId = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                FormControl(
                  child: TypographyApp(
                    text: "${widget.customer.name} ${widget.customer.lastName}",
                    variant: "subtitle2",
                  ),
                ),
                FormControl(
                  child: AutocompleteCurrencies(
                    token: widget.token,
                    onSelect: onSelect,
                  ),
                ),
                FormControl(
                  child: ElevatedButtonFuture(
                    future: future,
                    onPressed: () =>onSubmit(),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                    ),
                    child: const Text('Crear pedido'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
