import 'package:flutter/material.dart';

class DataTablePaginated extends StatelessWidget {
  final List<DataColumn> columns;
  final List<DataRow> rows;
  final double? columnSpacing;
  final double? horizontalMargin;
  final int? sortColumnIndex;
  final bool sortAscending;
  final int numberPage;
  final void Function()? onBack;
  final void Function()? onForwad;
  final Future? future;

  const DataTablePaginated({
    super.key,
    this.columnSpacing,
    this.horizontalMargin,
    this.sortColumnIndex,
    this.sortAscending = true,
    this.numberPage = 1,
    this.onBack,
    this.onForwad,
    this.future,
    required this.columns,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    if (future == null) {
      return buildTable(context);
    }

    return FutureBuilder(
        future: future,
        builder: (ctx, snapshot) {
          final bool loading =
              snapshot.connectionState == ConnectionState.waiting;

          if (loading) {
            return buildLoading(context);
          }

          return buildTable(context);
        });
  }

  Widget buildLoading(BuildContext context) {
    Color? color = Theme.of(context).colorScheme.primary;

    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(color: color),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildTable(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: DataTable(
                    columns: columns,
                    rows: rows,
                    columnSpacing: columnSpacing,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  IconButton(
                    onPressed: numberPage == 1 ? null : onBack,
                    icon: const Icon(Icons.arrow_left),
                  ),
                  IconButton(
                    onPressed: rows.length == 20 ? onForwad : null,
                    icon: const Icon(Icons.arrow_right),
                  ),
                ]),
              )
            ],
          ),
        ),
      ],
    );
  }
}
