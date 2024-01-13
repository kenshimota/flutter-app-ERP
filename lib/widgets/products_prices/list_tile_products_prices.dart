import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/formatters/date_formatter_app.dart';
import 'package:flutter_app_erp/widgets/column_cell.dart';
import 'package:flutter_app_erp/widgets/list_tile_app.dart';

import 'package:flutter_app_erp/widgets/list_view_app.dart';

import 'package:flutter_app_erp/core/response/products_prices/products_prices_response.dart';

import 'package:flutter_app_erp/widgets/slice_column.dart';
import 'package:flutter_app_erp/widgets/typography.dart';

class ListTileContentProductsPrices extends StatelessWidget {
  final ProductsPricesResponse productPrice;

  const ListTileContentProductsPrices({
    super.key,
    required this.productPrice,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: SliceColumn(
        children: [
          ColumnCell(
              subtitle: "Moneda: ", content: productPrice.currency!.code),
          ColumnCell(
              subtitle: "Producto: ", content: productPrice.product!.name),
          ColumnCell(subtitle: "precio: ", content: "${productPrice.price}"),
          ColumnCell(
            subtitle: "Creación",
            content: DateFormatterApp.dateTimeFormatter(productPrice.createdAt),
          ),
          ColumnCell(
            subtitle: "Actualización",
            content: DateFormatterApp.dateTimeFormatter(productPrice.updatedAt),
          ),
        ],
      ),
    );
  }
}

class ListTileProductPrice extends StatelessWidget {
  final ProductsPricesResponse productPrice;
  final void Function()? onAfterChange;

  const ListTileProductPrice({
    super.key,
    required this.productPrice,
    this.onAfterChange,
  });

  @override
  Widget build(BuildContext context) {
    return ListTileApp(
      leading: const CircleAvatar(
        child: Icon(Icons.production_quantity_limits),
      ),
      title: TypographyApp(text: "${productPrice.product!.name}", variant: "subtitle1",),
      heightContent: 100,
      content: ListTileContentProductsPrices(
        productPrice: productPrice,
      ),
    );
  }
}

class ListTileProductsPrices extends StatelessWidget {
  final int page;
  final Future? future;
  final void Function()? onForward;
  final List<ProductsPricesResponse> productPrice;
  final void Function()? onAfterChange;

  const ListTileProductsPrices({
    super.key,
    required this.productPrice,
    this.onAfterChange,
    this.onForward,
    this.page = 1,
    this.future,
  });

  Widget buildItem(BuildContext context, ProductsPricesResponse productPrice) {
    return Column(
      children: [
        ListTileProductPrice(
            productPrice: productPrice, onAfterChange: onAfterChange),
        const Divider(height: 1)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListViewApp(
      page: page,
      future: future,
      onNext: onForward,
      listItems: productPrice,
      buildItems: (context, product) => buildItem(context, product,),
    );
  }
}
