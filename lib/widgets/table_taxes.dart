import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/response/taxes/taxes_response.dart';
import 'package:flutter_app_erp/widgets/button_delete.dart';

class DataTableTaxes extends StatefulWidget {
  final List<TaxesResponse> list;
  final Function(Map<String, String>)? onOrden;
  const DataTableTaxes({super.key, required this.list, required this.onOrden});

  @override
  State<DataTableTaxes> createState() => _DataTableTaxesState();
}

class _DataTableTaxesState extends State<DataTableTaxes>{
  int? sortColumnIndex;
  bool sortAscending = true;

  onSort(int n, bool b){
    final list = <String>["name", "percentage", "created_at", "updated_at"]; 
    
    setState(() {
      sortColumnIndex = n;
      sortAscending = b;
    });

    String type = b ? "asc" : "desc";
    widget.onOrden!({'field': list[n], 'type': type });

  }


  @override
  Widget build(BuildContext context) {
    final List<DataRow> rows = widget.list
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
        sortColumnIndex: sortColumnIndex,
        sortAscending: sortAscending,
        columns:  [
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
                'Impuestos',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            onSort: onSort,
          ),
          DataColumn(
            label: const Expanded(
              child: Text(
                'fecha de creado',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            onSort: onSort,
          ),
          const DataColumn(
            label: Expanded(
              child: Text(
                'Fecha de actualizacion',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
          DataColumn(
            label: const Expanded(
              child: Text(
                'Acciones',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            onSort: onSort,
          ),
        ],
        rows: rows,
      ),
    );
  }
}
