import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/shoppingCart/modelo_card_product_price.dart';
import 'package:flutter_app_erp/core/http/products_prices/get_list_product_prices.dart';
import 'package:flutter_app_erp/core/response/products_prices/products_prices_response.dart';

class CardProductsPrices extends StatefulWidget {
  final String token;

  const CardProductsPrices({super.key, required this.token});

  @override
  _CardProductsPrices createState() => _CardProductsPrices();
}

class _CardProductsPrices extends State<CardProductsPrices> {
  Future? futureList;
  List<ProductsPricesResponse> result = <ProductsPricesResponse>[];

  @override
  void initState() {
    super.initState();
    onRequest();
  }

  Future<void> onRequestApi() async {
    final List<ProductsPricesResponse> productPrice =
        await getListProductsPrices(
      token: widget.token,
    );

    setState(() {
      result = productPrice;
    });
  }

  Future<void> onRequest() async {
    setState(() {
      futureList = onRequestApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (result.isEmpty) {
      return const SizedBox(
        width: 100,
        height: 100,
      );
    }

    final ProductsPricesResponse productItem = result.elementAt(0);

    return ShowCardItem(productPrice: productItem);
  }
}
