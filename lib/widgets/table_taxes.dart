import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/response/taxes/taxes_response.dart';
import 'package:flutter_app_erp/widgets/button_delete.dart';

class DataTableTaxes extends StatelessWidget {
  final List<TaxesResponse> list;
  const DataTableTaxes({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    final List<DataRow> rows = list
        .map(
          (tax) => DataRow(
            cells: <DataCell>[
              DataCell(Text(tax.name)),
              DataCell(Text("${tax.percentage * 100}")),
              DataCell(Text(tax.createdAt.toString())),
              DataCell(Text(tax.updatedAt.toString())),
              DataCell(
                DeleteButtonTaxes(taxId: tax.id, context: context),
              ),
            ],
          ),
        )
        .toList();

    return SingleChildScrollView(
      child: DataTable(
        columnSpacing: 16, // Espacio entre columnas
        horizontalMargin: 16,
        columns: const <DataColumn>[
          DataColumn(
            label: Expanded(
              child: Text(
                'Nombre',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                'Impuestos',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                'fecha de creado',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                'Fecha de actualizacion',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                'Acciones',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
        ],
        rows: rows,
      ),
    );
  }
}
