import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/http/warehouse/get_list_warehouse.dart';
import 'package:flutter_app_erp/core/response/warehouse/warehouse_response.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AutocompleteWarehouses extends StatefulWidget {
  final String token;
  final Function(Map<String, dynamic>)? onSelect;

  const AutocompleteWarehouses({
    super.key,
    required this.token,
    this.onSelect,
  });

  @override
  AutocompleteWarehousesState createState() => AutocompleteWarehousesState();
}

class AutocompleteWarehousesState extends State<AutocompleteWarehouses> {
  Future? future;
  int? selected;
  List<WarehouseResponse> result = <WarehouseResponse>[];
  TextEditingController controlador = TextEditingController();

  Future<List<Map<String, dynamic>>> onRequestApi(String search) async {
    List<WarehouseResponse> warehouses = await getListWarehouse(
      order: {"field": "name", "type": "asc"},
      search: search,
      token: widget.token,
    );

    final List<Map<String, dynamic>> options =
        warehouses.map((e) => ({"name": e.name, "id": e.id})).toList();

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
          labelText: 'Deposito',
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
