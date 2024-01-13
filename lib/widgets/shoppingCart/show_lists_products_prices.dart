import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/response/products_prices/products_prices_response.dart';
import 'package:flutter_app_erp/widgets/list_view_scrolling_infinite.dart';
import 'package:flutter_app_erp/widgets/shoppingCart/modelo_card_product_price.dart';

class ShowListProductsPricesCards extends StatefulWidget {
  final List<ProductsPricesResponse> list;
  final Function()? onAdded;

  const ShowListProductsPricesCards({
    super.key,
    required this.list,
    this.onAdded,
  });

  @override
  State<ShowListProductsPricesCards> createState() =>
      _ShowListProductsPricesCards();
}

class _ShowListProductsPricesCards extends State<ShowListProductsPricesCards> {
  List<Widget> buildContent({required double width}) {
    double space = 310;
    int maxRow = width ~/ space;
    final List<Row> rows = [];
    List<Widget> children = [];

    for (final ProductsPricesResponse productPrice in widget.list) {
      children.add(ShowCardItem(
        productPrice: productPrice,
        onAdded: widget.onAdded,
      ));

      if (children.length == maxRow) {
        rows.add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ));
        children = [];
      }
    }

    if (children.isNotEmpty) {
      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ));
      children = [];
    }

    return rows;
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return ListViewScrollingInfinite(
      onNext: () => debugPrint("print"),
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children:
                    buildContent(width: width >= 900 ? width - 400 : width),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
