import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/http/currencies/get_list_currencies.dart';
import 'package:flutter_app_erp/core/response/currencies/currencies_response.dart';
import 'package:flutter_app_erp/widgets/butto_new_currencie.dart';
import 'package:flutter_app_erp/widgets/table_currencies.dart';
import 'package:flutter_app_erp/widgets/input_search.dart';
import 'package:flutter_app_erp/widgets/toobal_currencies.dart';

class ShowTableCurrencies extends StatefulWidget {
  final String token;
  const ShowTableCurrencies({super.key, required this.token});

  @override
  State<ShowTableCurrencies> createState() => _ShowTableCurrencies();

}

class _ShowTableCurrencies extends State<ShowTableCurrencies> {
  String search = '';
  int numberPage = 1;
  Future? futureList;
  Map<String, String>? order;
  List<CurrenciesResponse> result = <CurrenciesResponse>[];

  @override
  void initState(){
    setState((){
      futureList = onRequestApi();
    });

    super.initState();
  }

  Future<void> onRequestApi() async {
    final List<CurrenciesResponse> currencies = await getListCurrencies(
      token: widget.token,
      order: order,
      search: search,
      page: numberPage,
    );

    debugPrint('$currencies');

    setState(() {
      result = currencies;
    });
  }

  Future<void> onRequest() async {
    setState(() {
      futureList = onRequestApi();
    });
  }

  onSortOrder(Map<String, String> o) {
    setState(() {
      order = o;
      numberPage = 1;
    });

    onRequest();
  }

  onSearch(String s) {
    setState(() {
      search = s;
      numberPage = 1;
    });

    onRequest();
  }

  onBack() {
    setState(() {
      numberPage -= 1;
    });

    onRequest();
  }

  void onForwad() {
    setState(() {
      numberPage += 1;
    });

    onRequest();
  }

  @override
  Widget build(BuildContext build){
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ToobalCurrencies(
            onOrden: onSortOrder,
            inputSearch: InputSearch(
              onSearch: onSearch,
            )
          ),
          Expanded(
            child: Container(
            color: Colors.white,
            child: DataTableCurrencies(
              list: result,
              future: futureList,
              onOrden: onSortOrder,
              onBack: onBack,
              onForwad: onForwad,
              numberPage: numberPage,
              onAfterDelete: onRequest,
            ),

          ),),
          Padding(
            padding: const EdgeInsets.all(10),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonNewCurrencie(
                  onSave: () => onRequest(),
                )
              ],
            ),
          )
        ],
        )
    );
      
  }

}