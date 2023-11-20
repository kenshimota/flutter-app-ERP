import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_app_erp/core/http/taxes/get_list_taxes.dart';
import 'package:flutter_app_erp/core/response/taxes/taxes_response.dart';

class AutocompleteTaxes extends StatefulWidget {
  final String token;

  const AutocompleteTaxes({
    super.key,
    required this.token,
  });

  @override
  AutocompleteTaxesState createState() => AutocompleteTaxesState();
}

class AutocompleteTaxesState extends State<AutocompleteTaxes> {
  Future? future;
  List<TaxesResponse> result = <TaxesResponse>[];
  TextEditingController controlador = TextEditingController();

  Future<List<Map<String, dynamic>>> onRequestApi(String search) async {
    List<TaxesResponse> taxes = await getListTaxes(
      order: {"field": "percentage", "type": "asc"},
      search: search,
      token: widget.token,
    );

    final List<Map<String, dynamic>> options =
        taxes.map((e) => ({"name": e.name, "id": e.id})).toList();

    return options;
  }

  @override
  Widget build(BuildContext context) {
    return TypeAheadFormField<Map<String, dynamic>>(
      textFieldConfiguration: TextFieldConfiguration(
        controller: controlador,
        decoration: const InputDecoration(
          labelText: 'Impuesto',
        ),
      ),
      suggestionsCallback: onRequestApi,
      itemBuilder: (context, itemData) {
        return ListTile(
          title: Text(itemData['name']),
        );
      },
      onSuggestionSelected: (itemData) {
        setState(() {
          controlador.text = itemData['name'];
        });
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Por favor, selecciona un elemento';
        }
        return null;
      },
      onSaved: (value) {
        // Puedes guardar el valor seleccionado aquí si es necesario
      },
    );
  }
}
