import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/http/cities/get_list_cities.dart';
import 'package:flutter_app_erp/core/response/cities/cities_response.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';


class AutocompleteCity extends StatefulWidget {
  final String token;
  final Function(Map<String, dynamic>)? onSelect;

  const AutocompleteCity({
    super.key,
    required this.token,
    this.onSelect,
  });

  @override
  AutocompleteCityState createState() => AutocompleteCityState();
}

class AutocompleteCityState extends State<AutocompleteCity> {
  Future? future;
  int? selected;
  List<CitiesResponse> result = <CitiesResponse>[];
  TextEditingController controlador = TextEditingController();

  Future<List<Map<String, dynamic>>> onRequestApi(String search) async {
    List<CitiesResponse> cities = await getListCities(
      order: {"field": "name", "type": "asc"},
      search: search,
      token: widget.token,
    );

    final List<Map<String, dynamic>> options = 
      cities.map((e) => ({
        "id": e.id,
        "name": e.name, 
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
          labelText: 'Ciudad',
        ),
      ),
      suggestionsCallback: onRequestApi,
      itemBuilder: (context, itemData){
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