import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/exception/form_errors.dart';
import 'package:flutter_app_erp/core/exception/auth_errors.dart';
import 'package:flutter_app_erp/core/http/customers/create_customer.dart';
import 'package:flutter_app_erp/core/response/customers/customers_response.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:flutter_app_erp/widgets/autocomplete/autocomplete_city.dart';
import 'package:flutter_app_erp/widgets/autocomplete/autocomplete_states.dart';
import 'package:flutter_app_erp/widgets/elevated_button_future.dart';
import 'package:flutter_app_erp/widgets/form_control.dart';
import 'package:flutter_app_erp/widgets/input_name.dart';
import 'package:flutter_app_erp/widgets/input_identity.dart';
import 'package:flutter_app_erp/widgets/input_address.dart';
import 'package:provider/provider.dart';

class FormCustomer extends StatefulWidget {
  final String token;
  final void Function(CustomersResponse)? onSave;
  //final CustomersResponse customer;

  const FormCustomer({
    super.key,
    this.onSave,
    required this.token,
   // required this.customer,
  });

  @override
  State<FormCustomer> createState() => _FormCustomerState();
}

class _FormCustomerState extends State<FormCustomer> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future? future;
  TextEditingController name = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController identityDocument = TextEditingController();
  TextEditingController address = TextEditingController();
  int? stateId;
  int? cityId;


  FormErrors errors = FormErrors(map: {});

  onRequest() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      CustomersResponse customer = await createCustomer(
          token: widget.token,
          name: name.text,
          lastName: lastName.text,
          identityDocument: int.parse(identityDocument.text),
          address: address.text,
          stateId: stateId as int,
          cityId: cityId as int, 
          
          );
     
      widget.onSave!(customer);
    } on AuthErrors  {
      authProvider.signOut();
    } on FormErrors catch (e) {
      setState(() {
        errors = e;
      });
    }
  }

  onSubmit(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return null;
    }

    setState(() {
      future = onRequest();
    });
  }

   onSelect(Map<String, dynamic>? state) {
    setState(() {
      int? value = state == null ? null : state["id"];
      stateId = value;
    });
  }

    onSelectCity(Map<String, dynamic>? city) {
    setState(() {
      int? value = city == null ? null : city["id"];
      cityId = value;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child:Column(
          children: [
            FormControl(
              child: InputName(
                controller: name,
                future: future,
                isRequired: true,
                errorText: errors.getValue("name"),
              ),
            ),
            FormControl(
                child: InputName(
              controller: lastName,
              label: "Apellido",
              future: future,
              isRequired: true,
              errorText: errors.getValue("lastName"),
            )),
            FormControl(
                child: InputIdentityDocument(
              controller: identityDocument,
              future: future,
              errorText: errors.getValue("identityDocument"),
            )),
            FormControl(
              child: InputAddress(
                controller: address,
                future: future,
                isRequired: true,
                errorText: errors.getValue("address"),
              ),
            ),
            FormControl(
                  child: AutocompleteStates(
                    token: widget.token,
                    onSelect: onSelect,
                  ),
                ),
            FormControl(
                  child: AutocompleteCity(
                    token: widget.token,
                    onSelect: onSelectCity,
                  ),
                ),
            FormControl(
              child: ElevatedButtonFuture(
                onPressed: () => onSubmit(context),
                future: future,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text('Crear cliente'),
              ),
            ),
          ],
        )));
  }
}

  
