import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/http/states/get_list_states.dart';
import 'package:flutter_app_erp/core/response/states/response_states.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AutocompleteStates extends StatefulWidget {
  final String token;
  final Function(Map<String, dynamic>)? onSelect;

  const AutocompleteStates({
    super.key,
    required this.token,
    this.onSelect,
  });

  @override
  AutocompleteStatesState createState() => AutocompleteStatesState();
}

class AutocompleteStatesState extends State<AutocompleteStates> {
  Future? future;
  int? selected;
  List<StatesResponse> result = <StatesResponse>[];
  TextEditingController controlador = TextEditingController();

  Future<List<Map<String, dynamic>>> onRequestApi(String search) async {
    List<StatesResponse> states = await getListStates(
     order: {"field": "name", "type": "asc"},
     search: search,
     token: widget.token,
    );

    final List<Map<String,dynamic>> options = 
      states.map((e) => ({
        "name": e.name,
        "id": e.id,
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
        labelText: 'Estado',
      ),
      ),
      suggestionsCallback: onRequestApi,
      itemBuilder: (context, itemData){
        return ListTile(
          title: Text("${itemData['name']}"),
        );
      },
     onSuggestionSelected: (itemData) {
        widget.onSelect!(itemData);

        setState(() {
          selected = itemData["id"];
          controlador.text = "${itemData['name']}";
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