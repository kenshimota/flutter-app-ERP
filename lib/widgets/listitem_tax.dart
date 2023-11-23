import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/list_view_app.dart';
import 'package:flutter_app_erp/widgets/popup_menu_button_tax.dart';
import 'package:flutter_app_erp/core/response/taxes/taxes_response.dart';
import 'package:flutter_app_erp/core/ formatters/number_formatter_app.dart';

class ListTileTax extends StatelessWidget {
  final TaxesResponse tax;
  final void Function()? onAfterChange;

  const ListTileTax({super.key, required this.tax, this.onAfterChange});

  @override
  Widget build(BuildContext context) {
    final String name = tax.name;
    final String firstLetter = name[0].toUpperCase();

    return ListTile(
      leading: CircleAvatar(child: Text(firstLetter)),
      title: Text(name),
      subtitle: Text(NumberFormatterApp.percentageFormat(tax.percentage)),
      trailing: PopupMenuApp(
        tax: tax,
        onAfterChange: onAfterChange,
      ),
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
