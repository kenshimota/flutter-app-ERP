import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_app_erp/core/http/products/get_list_products.dart';
import 'package:flutter_app_erp/core/response/products/products_response.dart';

class AutocompleteProducts extends StatefulWidget {
  final String token;
  final Function(Map<String, dynamic>)? onSelect;

  const AutocompleteProducts({
    super.key,
    required this.token,
    this.onSelect,
  });

  @override
  AutocompleteProductsState createState() => AutocompleteProductsState();
}

class AutocompleteProductsState extends State<AutocompleteProducts> {
  Future? future;
  int? selected;
  List<ProductsResponse> result = <ProductsResponse>[];
  TextEditingController controlador = TextEditingController();

  Future<List<Map<String, dynamic>>> onRequestApi(String search) async {
    List<ProductsResponse> products = await getListProducts(
      order: {"field": "code", "type": "asc"},
      search: search,
      token: widget.token,
    );

    final List<Map<String, dynamic>> options = products
        .map((e) => ({"name": "${e.code} - ${e.name}", "id": e.id}))
        .toList();

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
          labelText: 'Producto',
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
