import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/%20formatters/date_formatter_app.dart';
import 'package:flutter_app_erp/widgets/column_cell.dart';
import 'package:flutter_app_erp/widgets/list_tile_app.dart';

import 'package:flutter_app_erp/widgets/list_view_app.dart';
import 'package:flutter_app_erp/widgets/popup_menu_button_tax.dart';
import 'package:flutter_app_erp/core/response/taxes/taxes_response.dart';
import 'package:flutter_app_erp/core/ formatters/number_formatter_app.dart';
import 'package:flutter_app_erp/widgets/slice_column.dart';
import 'package:flutter_app_erp/widgets/typography.dart';

class ListTileTaxContent extends StatelessWidget {
  final TaxesResponse tax;

  const ListTileTaxContent({super.key, required this.tax});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: SliceColumn(
        children: [
          ColumnCell(subtitle: "Nombre: ", content: tax.name),
          ColumnCell(
              subtitle: "Porcentaje: ",
              content: NumberFormatterApp.percentageFormat(tax.percentage)),
          ColumnCell(
            subtitle: "Creación: ",
            content: DateFormatterApp.dateTimeFormatter(tax.createdAt),
          ),
          ColumnCell(
            subtitle: "Actualización: ",
            content: DateFormatterApp.dateTimeFormatter(tax.updatedAt),
          ),
        ],
      ),
    );
  }
}

class ListTileTax extends StatelessWidget {
  final TaxesResponse tax;
  final void Function()? onAfterChange;

  const ListTileTax({super.key, required this.tax, this.onAfterChange});

  @override
  Widget build(BuildContext context) {
    final String name = tax.name;

    return ListTileApp(
      leading: const CircleAvatar(child: Icon(Icons.percent)),
      title: TypographyApp(text: name, variant: "subtitle2"),
      subtitle: TypographyApp(
        variant: "body1",
        text: NumberFormatterApp.percentageFormat(tax.percentage),
      ),
      trailing: PopupMenuApp(
        tax: tax,
        onAfterChange: onAfterChange,
      ),
      heightContent: 70,
      content: ListTileTaxContent(tax: tax),
    );
  }
}

class ListTileTaxes extends StatelessWidget {
  final int page;
  final Future? future;
  final void Function()? onForward;
  final List<TaxesResponse> listTax;
  final void Function()? onAfterChange;

  const ListTileTaxes({
    super.key,
    required this.listTax,
    this.onAfterChange,
    this.onForward,
    this.page = 1,
    this.future,
  });

  Widget buildItem(BuildContext context, TaxesResponse tax) {
    return Column(
      children: [
        ListTileTax(tax: tax, onAfterChange: onAfterChange),
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
      listItems: listTax,
      buildItems: (context, tax) => buildItem(context, tax),
    );
  }
}
