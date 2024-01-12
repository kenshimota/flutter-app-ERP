import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/response/currencies/currencies_response.dart';
import 'package:flutter_app_erp/widgets/button_delete_currencie.dart';
import 'package:flutter_app_erp/widgets/data_table_paginated.dart';
import 'package:flutter_app_erp/core/formatters/date_formatter_app.dart';
import 'package:flutter_app_erp/core/formatters/number_formatter_app.dart';
import 'package:flutter_app_erp/widgets/button_edit_currencie.dart';
import 'package:flutter_app_erp/widgets/typography.dart';

class DataTableCurrencies extends StatefulWidget {
  final int numberPage;
  final List<CurrenciesResponse> list;
  final void Function()? onForwad;
  final void Function()? onBack;
  final Future? future;
  final Function(Map<String, String>)? onOrden;
  final void Function()? onAfterDelete;

  const DataTableCurrencies({
    super.key,
    required this.list,
    required this.onOrden,
    this.onForwad,
    this.onBack,
    this.numberPage = 1,
    this.future,
    this.onAfterDelete,
  });

  @override
  State<DataTableCurrencies> createState() => _DataTableCurrencies();
}

class _DataTableCurrencies extends State<DataTableCurrencies> {
  int? sortColumnIndex;
  bool sortAscending = true;

  onSort(int n, bool b) {
    final list = <String>[
      "name",
      "symbol",
      "code",
      "exchange_rate",
      "created_at",
      "updated_at"
    ];

    setState(() {
      sortColumnIndex = n;
      sortAscending = b;
    });

    String type = b ? "asc" : "desc";
    widget.onOrden!({'field': list[n], 'type': type});
  }

  @override
  Widget build(BuildContext context) {
    final List<DataRow> rows = widget.list
        .map((currencie) => DataRow(cells: <DataCell>[
              DataCell(TypographyApp(
                text: currencie.name,
                variant: "body1",
              )),
              DataCell(TypographyApp(
                text: currencie.symbol,
                variant: "body1",
              )),
              DataCell(TypographyApp(text: currencie.code)),
              DataCell(
                TypographyApp(
                  text: NumberFormatterApp.format(
                    currencie.exchangeRate,
                  ),
                  variant: "body1",
                ),
              ),
              DataCell(TypographyApp(
                variant: "body1",
                text: DateFormatterApp.dateTimeFormatter(currencie.createdAt),
              )),
              DataCell(TypographyApp(
                variant: "body1",
                text: DateFormatterApp.dateTimeFormatter(currencie.updatedAt),
              )),
              DataCell(Row(
                children: [
                  ButtonEditCurrencie(
                    currencie: currencie,
                    onSave: widget.onAfterDelete,
                  ),
                  const SizedBox(
                    width: 8,
                    height: 8,
                  ),
                  ButtonDeleteCurrencie(
                    currencieId: currencie.id,
                    context: context,
                    onAfterDelete: widget.onAfterDelete,
                  )
                ],
              )),
            ]))
        .toList();
    return DataTablePaginated(
        future: widget.future,
        onBack: widget.onBack,
        onForwad: widget.onForwad,
        numberPage: widget.numberPage,
        columnSpacing: 16, // Espacio entre columnas
        horizontalMargin: 16,
        sortColumnIndex: sortColumnIndex,
        sortAscending: sortAscending,
        columns: [
          DataColumn(
            label: const Expanded(
              child: TypographyApp(
                variant: "subtitle2",
                text: 'Nombre',
              ),
            ),
            onSort: onSort,
          ),
          DataColumn(
              label: const Expanded(
                child: TypographyApp(
                  variant: "subtitle2",
                  text: 'Simbolo',
                ),
              ),
              onSort: onSort),
          DataColumn(
              label: const Expanded(
                child: TypographyApp(
                  variant: "subtitle2",
                  text: 'Codigo',
                ),
              ),
              onSort: onSort),
          DataColumn(
              label: const Expanded(
                child: TypographyApp(
                  variant: "subtitle2",
                  text: 'Taza de cambio',
                ),
              ),
              onSort: onSort),
          DataColumn(
              label: const Expanded(
                child: TypographyApp(
                  variant: "subtitle2",
                  text: 'Fecha de creado',
                ),
              ),
              onSort: onSort),
          DataColumn(
              label: const Expanded(
                child: TypographyApp(
                  variant: "subtitle2",
                  text: 'Fecha de actualizado',
                ),
              ),
              onSort: onSort),
          const DataColumn(
            label: Expanded(
              child: TypographyApp(
                variant: "subtitle2",
                text: 'Acciones',
              ),
            ),
          ),
        ],
        rows: rows);
  }
}
