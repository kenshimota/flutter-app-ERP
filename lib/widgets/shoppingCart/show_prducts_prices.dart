import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/http/products_prices/get_list_product_prices.dart';
import 'package:flutter_app_erp/core/response/products_prices/products_prices_response.dart';
import 'package:flutter_app_erp/widgets/form_control.dart';
import 'package:flutter_app_erp/widgets/input_search.dart';
import 'package:flutter_app_erp/widgets/shoppingCart/toobal_shopping_cart.dart';
import 'package:flutter_app_erp/widgets/shoppingCart/show_lists_products_prices.dart';

class ShowProductsPrices extends StatefulWidget {
  final String token;
  const ShowProductsPrices({super.key, required this.token});

  @override
  State<ShowProductsPrices> createState() => _ShowProductsPrices();
}

class _ShowProductsPrices extends State<ShowProductsPrices> {
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
      search: search,
      page: numberPage,
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

  onSearch(String s) {
    setState(() {
      search = s;
      numberPage = 1;
    });

    onRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              SizedBox(
                width: 450,
                child: FormControl(
                  child: ToobalShoppingCart(
                    inputSearch: InputSearch(onSearch: onSearch),
                  ),
                ),
              ),
              Expanded(
                child: ShowListProductsPricesCards(
                  list: result,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 400,
          color: Colors.red,
        ),
      ],
    );
  }
}
