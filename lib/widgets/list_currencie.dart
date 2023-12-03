import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/%20formatters/date_formatter_app.dart';
import 'package:flutter_app_erp/core/response/currencies/currencies_response.dart';
import 'package:flutter_app_erp/core/ formatters/number_formatter_app.dart';
import 'package:flutter_app_erp/widgets/column_cell.dart';
import 'package:flutter_app_erp/widgets/list_tile_app.dart';
import 'package:flutter_app_erp/widgets/list_view_app.dart';
import 'package:flutter_app_erp/widgets/popup_menu_currencie.dart';
import 'package:flutter_app_erp/widgets/slice_column.dart';
import 'package:flutter_app_erp/widgets/typography.dart';

class ArticleCurrencieContent extends StatelessWidget {
  final CurrenciesResponse currency;

  const ArticleCurrencieContent({super.key, required this.currency});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 70,
        child: SliceColumn(
          children: [
            ColumnCell(subtitle: "Nombre: ", content: currency.name),
            ColumnCell(subtitle: "Codigo: ", content: currency.code),
            ColumnCell(subtitle: "Simbolo: ", content: currency.symbol),
            ColumnCell(
              subtitle: "Tasa de Cambio: ",
              content: NumberFormatterApp.format(currency.exchangeRate),
            ),
            ColumnCell(
              subtitle: "Creación: ",
              content: DateFormatterApp.dateTimeFormatter(currency.createdAt),
            ),
            ColumnCell(
              subtitle: "Actualización",
              content: DateFormatterApp.dateTimeFormatter(currency.updatedAt),
            ),
          ],
        ));
  }
}

class ArticleCurrencie extends StatelessWidget {
  final CurrenciesResponse currencie;
  final void Function()? onAfterChange;

  const ArticleCurrencie({
    super.key,
    this.onAfterChange,
    required this.currencie,
  });

  @override
  Widget build(BuildContext context) {
    return ListTileApp(
      leading: const CircleAvatar(child: Icon(Icons.currency_exchange)),
      title: TypographyApp(
        text: "${currencie.name} (${currencie.code})",
        variant: "subtitle2",
      ),
      subtitle: TypographyApp(
        variant: "body1",
        text: NumberFormatterApp.format(currencie.exchangeRate),
      ),
      trailing: PopupMenuCurrencie(
        currencie: currencie,
        onAfterChange: onAfterChange,
      ),
      content: ArticleCurrencieContent(
        currency: currencie,
      ),
      heightContent: 70,
    );
  }
}

class ListTileCurrencies extends StatelessWidget {
  final int page;
  final Future? future;
  final void Function()? onForward;
  final List<CurrenciesResponse> listcurrencie;

  final void Function()? onAfterChange;

  const ListTileCurrencies({
    super.key,
    this.onForward,
    this.future,
    this.page = 1,
    required this.listcurrencie,
    this.onAfterChange,
  });

  Widget buildItem(BuildContext context, CurrenciesResponse currency) {
    return Column(
      children: [
        ArticleCurrencie(
          currencie: currency,
          onAfterChange: onAfterChange,
        ),
        const Divider(height: 1)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListViewApp(
      page: page,
      onNext: onForward,
      future: future,
      listItems: listcurrencie,
      buildItems: (context, currency) => buildItem(context, currency),
    );
  }
}
