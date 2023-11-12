import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/response/warehouse/warehouse_response.dart';
import 'package:flutter_app_erp/widgets/popup_menu_warehouse.dart';

class ListTileWare extends StatelessWidget {
  final WarehouseResponse ware;
  final void Function()? onAfterChange;

  const ListTileWare({super.key, required this.ware, this.onAfterChange});

  @override
  Widget build(BuildContext context) {
    final String name = ware.name;
    final String address = ware.address;
    final String firstLetter = name[0].toUpperCase();

    return ListTile(
      leading: CircleAvatar(child: Text(firstLetter)),
      title: Text(name),
      subtitle: Text(address),
      trailing: PopupMenuWarehouse(
        ware: ware, 
        onAfterChange: onAfterChange,
      ),
    );
  }
}

class ListTileWarehouse extends StatelessWidget {
  final List<WarehouseResponse> listWare;
  final void Function()? onAfterChange;


  const ListTileWarehouse(
      {super.key, required this.listWare, this.onAfterChange });

  @override
  Widget build(BuildContext context) {
    final List<Widget> warehouses = listWare
        .map((ware) => Column(
              children: [
                ListTileWare(ware: ware, onAfterChange: onAfterChange,),
                const Divider(height: 1,),
              ],
            ))
        .toList();
    return ListView(
      children: warehouses,
    );
  }
}
