import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/%20formatters/date_formatter_app.dart';
import 'package:flutter_app_erp/core/response/warehouse/warehouse_response.dart';
import 'package:flutter_app_erp/widgets/column_cell.dart';
import 'package:flutter_app_erp/widgets/list_tile_app.dart';
import 'package:flutter_app_erp/widgets/list_view_app.dart';
import 'package:flutter_app_erp/widgets/popup_menu_warehouse.dart';
import 'package:flutter_app_erp/widgets/slice_column.dart';
import 'package:flutter_app_erp/widgets/typography.dart';

class ListTileWareContent extends StatelessWidget {
  final WarehouseResponse ware;

  const ListTileWareContent({super.key, required this.ware});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: SliceColumn(
        children: [
          ColumnCell(subtitle: "Nombre: ", content: ware.name),
          ColumnCell(subtitle: "Dirección: ", content: ware.address),
          ColumnCell(
            subtitle: "Creación: ",
            content: DateFormatterApp.dateTimeFormatter(ware.createdAt),
          ),
          ColumnCell(
            subtitle: "Actualización: ",
            content: DateFormatterApp.dateTimeFormatter(ware.updatedAt),
          ),
        ],
      ),
    );
  }
}

class ListTileWare extends StatelessWidget {
  final WarehouseResponse ware;
  final void Function()? onAfterChange;

  const ListTileWare({super.key, required this.ware, this.onAfterChange});

  @override
  Widget build(BuildContext context) {
    final String name = ware.name;

    return ListTileApp(
      leading: const CircleAvatar(child: Icon(Icons.warehouse)),
      title: TypographyApp(
        text: name,
        variant: "subtitle2",
      ),
      subtitle: TypographyApp(text: ware.address, variant: "body1"),
      trailing: PopupMenuWarehouse(
        ware: ware,
        onAfterChange: onAfterChange,
      ),
      heightContent: 50,
      content: ListTileWareContent(
        ware: ware,
      ),
    );
  }
}

class ListTileWarehouse extends StatelessWidget {
  final int page;
  final Future? future;
  final void Function()? onForward;
  final void Function()? onAfterChange;
  final List<WarehouseResponse> listWare;

  const ListTileWarehouse({
    super.key,
    required this.listWare,
    this.onAfterChange,
    this.future,
    this.onForward,
    this.page = 1,
  });

  Widget buildItem(BuildContext context, WarehouseResponse warehouse) {
    return Column(
      children: [
        ListTileWare(ware: warehouse, onAfterChange: onAfterChange),
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
      buildItems: (context, warehouse) => buildItem(context, warehouse),
      listItems: listWare,
    );
  }
}
