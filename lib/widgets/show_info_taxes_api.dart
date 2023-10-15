import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/http/taxes/get_list_taxes.dart';
import 'package:flutter_app_erp/widgets/button_new_tax.dart';

import 'package:flutter_app_erp/widgets/input_search.dart';
import 'package:flutter_app_erp/widgets/layourt_twice_builder.dart';
import 'package:flutter_app_erp/widgets/table_taxes.dart';
import 'package:flutter_app_erp/core/response/taxes/taxes_response.dart';
import 'package:flutter_app_erp/widgets/listitem_tax.dart';
import 'package:flutter_app_erp/widgets/toobal_taxes.dart';

class ShowInfoTaxes extends StatefulWidget {
  final String token;

  const ShowInfoTaxes({
    super.key,
    required this.token,
  });

  @override
  State<ShowInfoTaxes> createState() => _ShowInfotaxesState();
}

class _ShowInfotaxesState extends State<ShowInfoTaxes> {
  String search = '';
  int numberPage = 1;
  Future? futureList;
  Map<String, String>? order;
  List<TaxesResponse> result = <TaxesResponse>[];

  @override
  initState() {
    super.initState();
    setState(() {
      futureList = onRequestApi();
    });
  }

  Future<void> onRequestApi() async {


    List<TaxesResponse> taxes = await getListTaxes(
      order: order,
      search: search,
      page: numberPage,
      token: widget.token,
    );



    setState(() {
      result = taxes;
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
         ToobalTaxes(inputSearch: InputSearch(onSearch: onSearch,)),
          Expanded(
            child: Container(
                color: Colors.white,
                child: LayourtTwiceBuilder(
                  mobile: ListTileApp(
                    listTax: result,
                    onAfterChange: onRequest,
                  ),
                  desktop: DataTableTaxes(
                    future: futureList,
                    list: result,
                    onOrden: onSortOrder,
                    onBack: onBack,
                    onForwad: onForwad,
                    numberPage: numberPage,
                    onAfterDelete: onRequest,
                  ),
                )

                /*, */
                ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonNewTax(
                  onSave: () => onRequest(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
