import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/elevated_button_future.dart';
import 'package:flutter_app_erp/widgets/form_control.dart';
import 'package:flutter_app_erp/widgets/input_identity.dart';
import 'package:flutter_app_erp/widgets/input_search.dart';
import 'package:flutter_app_erp/widgets/typography.dart';
import 'package:flutter_app_erp/core/http/customers/get_list_customers.dart';
import 'package:flutter_app_erp/core/response/customers/customers_response.dart';

class FormOrdersSearch extends StatefulWidget {
  final String token;
  final void Function(CustomersResponse?)? getCustomer;

  const FormOrdersSearch({
    super.key,
    required this.token,
    this.getCustomer,
  });

  @override
  State<FormOrdersSearch> createState() => _FormOrdersSearch();
}

class _FormOrdersSearch extends State<FormOrdersSearch> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController identity = TextEditingController();
  List<CustomersResponse> result = <CustomersResponse>[];
  Future? futureList;

  Future<void> onRequestApi() async {
    final List<CustomersResponse> customers = await getListCustomers(
      token: widget.token,
      search: identity.text,
    );

    for (final customer in customers) {
      if (customer.identityDocument == int.parse(identity.text)) {
        widget.getCustomer!(customer);
        return;
      }
    }

    widget.getCustomer!(null);
  }

  Future<void> onRequest() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      futureList = onRequestApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                const FormControl(
                  child: Center(
                    child: Icon(
                      Icons.search,
                      size: 80.0,
                    ),
                  ),
                ),
                const FormControl(
                  child: TypographyApp(
                    text: "Busqueda",
                    variant: "h5",
                    color: "primary",
                  ),
                ),
                FormControl(
                  child: InputIdentityDocument(
                    future: futureList,
                    controller: identity,
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
                FormControl(
                  child: ElevatedButtonFuture(
                    onPressed: () => onRequest(),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                    ),
                    child: const Text('Buscar'),
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
