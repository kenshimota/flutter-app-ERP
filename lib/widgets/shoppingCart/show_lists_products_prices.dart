import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/response/products_prices/products_prices_response.dart';
import 'package:flutter_app_erp/widgets/list_view_scrolling_infinite.dart';
import 'package:flutter_app_erp/widgets/shoppingCart/modelo_card_product_price.dart';
import 'package:flutter_app_erp/widgets/typography.dart';

class ShowListProductsPricesCards extends StatefulWidget {
  final Future? future;
  final Function()? onAdded;
  final Function()? onNext;
  final List<ProductsPricesResponse> list;

  const ShowListProductsPricesCards({
    super.key,
    required this.list,
    this.onAdded,
    this.future,
    this.onNext,
  });

  @override
  State<ShowListProductsPricesCards> createState() =>
      _ShowListProductsPricesCards();
}

class _ShowListProductsPricesCards extends State<ShowListProductsPricesCards> {
  void onNext() {
    if (widget.list.isEmpty || widget.list.length % 20 != 0) {
      return;
    }

    widget.onNext!();
  }

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

  Widget circuleProgress(BuildContext context) {
    Color? color = Theme.of(context).colorScheme.primary;

    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: CircularProgressIndicator(color: color),
          ),
        )
      ],
    );
  }

  Widget buildNotFound({required BuildContext context}) {
    return const Center(
      child: SizedBox(
        height: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Center(
                  child: Icon(
                    Icons.search_off,
                    size: 80,
                  ),
                ),
                Center(
                  child: TypographyApp(
                    text: "No se han encontrado resultados",
                    variant: "h5",
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildListPrices({required BuildContext context}) {
    final double width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Expanded(
          child: Column(
            children: buildContent(width: width >= 900 ? width - 400 : width),
          ),
        ),
      ],
    );
  }

  Widget buildLayout({required BuildContext context, bool loading = false}) {
    if (!loading && widget.list.isEmpty) {
      return buildNotFound(context: context);
    }

    if (loading) {
      ListViewScrollingInfinite(
        countChildren: false,
        onNext: onNext,
        children: [buildListPrices(context: context), circuleProgress(context)],
      );
    }

    return ListViewScrollingInfinite(
      countChildren: false,
      onNext: onNext,
      children: [buildListPrices(context: context)],
    );
  }

  Widget futureBuild(BuildContext context, AsyncSnapshot snapshot) {
    final bool loading = snapshot.connectionState == ConnectionState.waiting;
    return buildLayout(context: context, loading: loading);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.future == null) {
      return buildLayout(context: context);
    }

    return FutureBuilder(future: widget.future, builder: futureBuild);
  }
}
