import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/http/taxes/get_list_taxes.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:flutter_app_erp/widgets/circular_button.dart';
import 'package:flutter_app_erp/widgets/input_search.dart';
import 'package:flutter_app_erp/widgets/table_taxes.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_erp/core/response/taxes/taxes_response.dart';

class ShowInfoTaxes extends StatefulWidget {
  final List<DataRow> rows;
  const ShowInfoTaxes({super.key, required this.rows});
  @override
  State<ShowInfoTaxes> createState() => _ShowInfotaxesState();
}

class _ShowInfotaxesState extends State<ShowInfoTaxes> {
  String search = '';
  Map<String, String>? order;
  int numberPage = 1;

  List<TaxesResponse> result = <TaxesResponse>[];

  Future<void> onRequest(String token) async {
    List<TaxesResponse> taxes =
        await getListTaxes(token: token, search: search, order: order, page: numberPage);

    setState(() {
      result = taxes;
    });
  }

  onSortOrder(Map<String, String> o, String token) {
    setState(() {
      order = o;
      numberPage = 1;
    });
    onRequest(token);
  }

  onSearch(String s, String token) {
    setState(() {
      search = s;
      numberPage = 1;
    });

    onRequest(token);
  }

  onBack( String token ){
      setState(() {
        numberPage -=  1;
      });
    
    onRequest(token);
  }


  onForwad(String token){
    setState(() {
      numberPage += 1;
    });
    onRequest(token);
  }

  onPressed() {
    debugPrint('hola');
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final String? token = authProvider.getToken();

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 400,
                  child: InputSearch(
                      onSearch: (String s) => onSearch(s, token ?? '')),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: DataTableTaxes(
                list: result,
                onOrden: (Map<String, String> order) =>
                    onSortOrder(order, token ?? ''),
                    onBack: ()=> onBack(token??''),
                    onForwad: ()=> onForwad(token??''),
                    numberPage: numberPage,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularButton(
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: onPressed),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => token == null ? null : onRequest(token),
            child: const Text('hacer Click'),
          ),
        ],
      ),
    );
  }
}
