import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/http/currencies/get_list_currencies.dart';
import 'package:flutter_app_erp/core/response/currencies/currencies_response.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AutocompleteCurrencies extends StatefulWidget {
  final String token;
  final Function(Map<String, dynamic>)? onSelect;

  const AutocompleteCurrencies({
    super.key,
    required this.token,
    this.onSelect,
  });

  @override
  AutocompleteCurrenciesState createState() => AutocompleteCurrenciesState();
}

class AutocompleteCurrenciesState extends State<AutocompleteCurrencies> {
  Future? future;
  int? selected;
  List<CurrenciesResponse> result = <CurrenciesResponse>[];
  TextEditingController controlador = TextEditingController();

  Future<List<Map<String, dynamic>>> onRequestApi(String search) async {
    List<CurrenciesResponse> currencies = await getListCurrencies(
      order: {"field": "name", "type": "asc"},
      search: search,
      token: widget.token,
    );

    final List<Map<String, dynamic>> options = 
      currencies.map((e) => ({
        "id": e.id,
        "name": e.name, 
        "code": e.code, 
        "symbol": e.symbol
      })).toList();

    setState(() {
      selected = null;
    });

    return options;
  
  }

  @override
  Widget build(BuildContext context){
    return TypeAheadFormField<Map<String, dynamic>>(
      textFieldConfiguration: TextFieldConfiguration(
        controller: controlador,
        decoration: const InputDecoration(
          labelText: 'Moneda',
        ),
      ),
      suggestionsCallback: onRequestApi,
      itemBuilder: (context, itemData){
        return ListTile(
          title: Text("${itemData['code']} (${itemData['symbol']}) ${itemData['name']}"),
        );
      },
     onSuggestionSelected: (itemData) {
        widget.onSelect!(itemData);

        setState(() {
          selected = itemData["id"];
          controlador.text = "${itemData['code']} (${itemData['symbol']}) ${itemData['name']}";
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