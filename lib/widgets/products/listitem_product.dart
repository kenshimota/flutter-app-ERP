import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/%20formatters/date_formatter_app.dart';
import 'package:flutter_app_erp/core/%20formatters/number_formatter_app.dart';
import 'package:flutter_app_erp/widgets/column_cell.dart';
import 'package:flutter_app_erp/widgets/products/popup_menu_product.dart';
import 'package:flutter_app_erp/widgets/slice_column.dart';
import 'package:flutter_app_erp/widgets/typography.dart';
import 'package:flutter_app_erp/widgets/list_tile_app.dart';
import 'package:flutter_app_erp/widgets/list_view_app.dart';
import 'package:flutter_app_erp/core/response/products/products_response.dart';

class ListTileContentProduct extends StatelessWidget {
  final ProductsResponse product;

  const ListTileContentProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 100,
        child: SliceColumn(
          children: [
            ColumnCell(subtitle: "Nombre:", content: product.name),
            ColumnCell(subtitle: "Codigo:", content: product.code),
            ColumnCell(subtitle: "Impuesto:", content: product.tax!.name),
            ColumnCell(
              subtitle: "Existencia:",
              content: NumberFormatterApp.amount(product.stock),
            ),
            ColumnCell(
              subtitle: "Reserva",
              content: NumberFormatterApp.amount(product.reserved),
            ),
            ColumnCell(
              subtitle: "Creación",
              content: DateFormatterApp.dateTimeFormatter(product.createdAt),
            ),
            ColumnCell(
              subtitle: "Actualización",
              content: DateFormatterApp.dateTimeFormatter(product.updatedAt),
            ),
          ],
        ));
  }
}

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
      heightContent: 100,
      content: ListTileContentProduct(
        product: product,
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
