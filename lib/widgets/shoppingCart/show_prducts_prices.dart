import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/http/products_prices/get_list_product_prices.dart';
import 'package:flutter_app_erp/core/response/products_prices/products_prices_response.dart';
import 'package:flutter_app_erp/widgets/form_control.dart';
import 'package:flutter_app_erp/widgets/input_search.dart';
import 'package:flutter_app_erp/widgets/layourt_twice_builder.dart';
import 'package:flutter_app_erp/widgets/shoppingCart/toobal_shopping_cart.dart';
import 'package:flutter_app_erp/widgets/shoppingCart/show_lists_products_prices.dart';

class ShowProductsPrices extends StatefulWidget {
  final int orderId;
  final String token;
  final int currencyId;
  const ShowProductsPrices({
    super.key,
    required this.token,
    required this.currencyId,
    required this.orderId,
  });

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
    final productsPrices = await getListProductsPrices(
      token: widget.token,
      search: search,
      metadata: true,
      page: numberPage,
      currencyId: widget.currencyId,
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

  buildListPrices({required BuildContext context}) {
    return Column(
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
    );
  }

  Widget buildDesktop({required BuildContext context}) {
    return Row(
      children: [
        Expanded(
          child: buildListPrices(context: context),
        ),
        Container(
          width: 400,
          color: Colors.red,
        ),
      ],
    );
  }

  Widget buildNavbar({required BuildContext context}) {
    return Container(
      height: 60,
      color: Theme.of(context).colorScheme.primary,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              color: Colors.white,
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                color: Colors.white,
                icon: const Icon(Icons.shopping_cart),
                onPressed: () => Navigator.pop(context),
              )),
        ],
      ),
    );
  }

  Widget buildMobile({required BuildContext context}) {
    return Row(
      children: [
        Expanded(
            child: Column(
          children: [
            buildNavbar(context: context),
            Expanded(
              child: buildListPrices(context: context),
            )
          ],
        ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayourtTwiceBuilder(
      mobile: buildMobile(context: context),
      desktop: buildDesktop(context: context),
    );
  }
}
