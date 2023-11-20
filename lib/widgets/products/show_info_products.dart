import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/http/products/get_list_products.dart';
import 'package:flutter_app_erp/core/response/products/products_response.dart';

import 'package:flutter_app_erp/widgets/input_search.dart';
import 'package:flutter_app_erp/widgets/layourt_twice_builder.dart';
import 'package:flutter_app_erp/widgets/products/button_new_product.dart';
import 'package:flutter_app_erp/widgets/products/table_products.dart';
import 'package:flutter_app_erp/widgets/products/toolbar_products.dart';

class ShowInfoProducts extends StatefulWidget {
  final String token;

  const ShowInfoProducts({
    super.key,
    required this.token,
  });

  @override
  State<ShowInfoProducts> createState() => _ShowInfoProductsState();
}

class _ShowInfoProductsState extends State<ShowInfoProducts> {
  String search = '';
  int numberPage = 1;
  Future? futureList;
  Map<String, String>? order;
  List<ProductsResponse> result = <ProductsResponse>[];

  @override
  initState() {
    super.initState();
    setState(() {
      futureList = onRequestApi();
    });
  }

  Future<void> onRequestApi() async {
    List<ProductsResponse> products = await getListProducts(
      order: order,
      search: search,
      page: numberPage,
      token: widget.token,
    );

    setState(() {
      result = products;
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
          ToobalProducts(
            onOrden: onSortOrder,
            inputSearch: InputSearch(
              onSearch: onSearch,
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: LayourtTwiceBuilder(
                mobile: DataTableProducts(
                  future: futureList,
                  list: result,
                  onOrden: onSortOrder,
                  onBack: onBack,
                  onForwad: onForwad,
                  numberPage: numberPage,
                  onAfterDelete: onRequest,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonNewProduct(
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
