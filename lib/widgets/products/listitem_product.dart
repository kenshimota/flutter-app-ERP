import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/products/popup_menu_product.dart';
import 'package:flutter_app_erp/widgets/typography.dart';
import 'package:flutter_app_erp/widgets/list_tile_app.dart';
import 'package:flutter_app_erp/widgets/list_view_app.dart';
import 'package:flutter_app_erp/core/response/products/products_response.dart';

class ListTileProduct extends StatelessWidget {
  final ProductsResponse product;
  final void Function()? onAfterChange;

  const ListTileProduct({super.key, required this.product, this.onAfterChange});

  @override
  Widget build(BuildContext context) {
    return ListTileApp(
      leading: const CircleAvatar(
        child: Icon(Icons.production_quantity_limits),
      ),
      title: TypographyApp(text: product.code, variant: "subtitle1"),
      subtitle: TypographyApp(text: product.name, variant: "body1"),
      trailing: PopupMenuProduct(
        product: product,
        onAfterChange: onAfterChange,
      ),
    );
  }
}

class ListTileProducts extends StatelessWidget {
  final int page;
  final Future? future;
  final void Function()? onForward;
  final List<ProductsResponse> products;
  final void Function()? onAfterChange;

  const ListTileProducts({
    super.key,
    required this.products,
    this.onAfterChange,
    this.onForward,
    this.page = 1,
    this.future,
  });

  Widget buildItem(BuildContext context, ProductsResponse product) {
    return Column(
      children: [
        ListTileProduct(product: product, onAfterChange: onAfterChange),
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
      listItems: products,
      buildItems: (context, tax) => buildItem(context, tax),
    );
  }
}
