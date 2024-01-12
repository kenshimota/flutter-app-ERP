import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/input_search.dart';
import 'package:flutter_app_erp/widgets/container_white.dart';
import 'package:flutter_app_erp/widgets/products_prices/table_products_prices.dart';
import 'package:flutter_app_erp/widgets/products_prices/toobal_products_prices.dart';
import 'package:flutter_app_erp/widgets/products_prices/button_new_product_price.dart';
import 'package:flutter_app_erp/core/http/products_prices/get_list_product_prices.dart';
import 'package:flutter_app_erp/core/response/products_prices/products_prices_response.dart';

class ShowTableProductsPrices extends StatefulWidget {
  final String token;
  const ShowTableProductsPrices({
    super.key,
    required this.token,
  });

  @override
  State<ShowTableProductsPrices> createState() => _ShowTableProductsPrices();
}

class _ShowTableProductsPrices extends State<ShowTableProductsPrices> {
  String search = '';
  int numberPage = 1;
  Future? futureList;
  Map<String, String>? order;
  List<ProductsPricesResponse> result = <ProductsPricesResponse>[];

  @override
  void initState() {
    setState(() {
      futureList = onRequestApi();
    });

    super.initState();
  }

  Future<void> onRequestApi() async {
    final List<ProductsPricesResponse> productsPrices =
        await getListProductsPrices(
      token: widget.token,
      order: order,
      page: numberPage,
      search: search,
    );

    setState(() {
      result = productsPrices;
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
          ToobalProductPrice(
            onOrden: onSortOrder,
            inputSearch: InputSearch(
              onSearch: onSearch,
            ),
          ),
          Expanded(
            child: ContainerWhite(
              child: TableProductsPrices(
                list: result,
                onOrden: onSortOrder,
                onBack: onBack,
                onForwad: onForwad,
                numberPage: numberPage,
                onAfterDelete: onRequest,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonNewProductPrice(
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
