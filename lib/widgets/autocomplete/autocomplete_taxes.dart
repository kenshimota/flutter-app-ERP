import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_app_erp/core/http/taxes/get_list_taxes.dart';
import 'package:flutter_app_erp/core/response/taxes/taxes_response.dart';

class AutocompleteTaxes extends StatefulWidget {
  final String token;
  final Function(Map<String, dynamic>)? onSelect;

  const AutocompleteTaxes({
    super.key,
    required this.token,
    this.onSelect,
  });

  @override
  AutocompleteTaxesState createState() => AutocompleteTaxesState();
}

class AutocompleteTaxesState extends State<AutocompleteTaxes> {
  Future? future;
  int? selected;
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

    setState(() {
      selected = null;
    });

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
        widget.onSelect!(itemData);

        setState(() {
          selected = itemData["id"];
          controlador.text = itemData['name'];
        });
      },
      validator: (value) {
        if (selected == null) {
          return 'Por favor, selecciona un elemento';
        }

        return null;
      },
    );
  }
}
