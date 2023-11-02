import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/response/currencies/currencies_response.dart';
import 'package:flutter_app_erp/widgets/data_table_paginated.dart';
import 'package:flutter_app_erp/core/ formatters/date_formatter_app.dart';
import 'package:flutter_app_erp/core/ formatters/number_formatter_app.dart';

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
        .map((curren) => DataRow(cells: <DataCell>[
              DataCell(Text(curren.name)),
              DataCell(Text(curren.symbol)),
              DataCell(Text(curren.code)),
              DataCell(Text(NumberFormatterApp.format(curren.exchangeRate))),
              DataCell(Text(
                DateFormatterApp.dateTimeFormatter(curren.createdAt),
              )),
              DataCell(Text(
                DateFormatterApp.dateTimeFormatter(curren.updatedAt),
              )),
              DataCell(Row(
                children: [const Text('esta en construccion')],
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
              child: Text(
                'Nombre',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            onSort: onSort,
          ),
          DataColumn(
              label: const Expanded(
                child: Text(
                  'Simbolo',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              onSort: onSort),
          DataColumn(
              label: const Expanded(
                child: Text(
                  'Codigo',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              onSort: onSort),
          DataColumn(
              label: const Expanded(
                child: Text(
                  'Taza de cambio',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              onSort: onSort),
          DataColumn(
              label: const Expanded(
                child: Text(
                  'Fecha de creado',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              onSort: onSort),
          DataColumn(
              label: const Expanded(
                child: Text(
                  'Fecha de actualizado',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              onSort: onSort),
          const DataColumn(
            label: Expanded(
              child: Text(
                'Acciones',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
        ],
        rows: rows);
  }
}
