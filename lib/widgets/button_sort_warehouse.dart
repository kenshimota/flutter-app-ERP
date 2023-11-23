import 'package:flutter/material.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class ButtonSortWarehouse extends StatelessWidget {
  final Function(Map<String, String>)? onOrden;

  const ButtonSortWarehouse({super.key, this.onOrden});

  @override
  Widget build(BuildContext context) {
    return PopupButtonWarehouses(
      onOrden: onOrden,
    );
  }
}

class PopupButtonWarehouses extends StatefulWidget {
  final Function(Map<String, String>)? onOrden;
  const PopupButtonWarehouses({super.key, this.onOrden});

  @override
  State<PopupButtonWarehouses> createState() => _PopupButtonWarehousesState();
}

class _PopupButtonWarehousesState extends State<PopupButtonWarehouses> {
  SampleItem? selectedMenu;
  bool isAccending = false;

  onSort(SampleItem item) {
    final b = !isAccending;
    final index = item.index;
    final list = <String>["name", "address"];

    setState(() {
      selectedMenu = item;
      isAccending = b;
    });

    String type = b ? "asc" : "desc";

    if (widget.onOrden != null) {
      widget.onOrden!({'field': list[index], 'type': type});
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SampleItem>(
        icon: const Icon(Icons.sort),
        initialValue: selectedMenu,
        onSelected: onSort,
        itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
              PopupMenuItem<SampleItem>(
                value: SampleItem.itemOne,
                child: _SortWarehouseName(
                    text: 'Nombre',
                    isAccending: selectedMenu == SampleItem.itemOne
                        ? isAccending
                        : null),
              ),
              PopupMenuItem<SampleItem>(
                value: SampleItem.itemTwo,
                child: _SortWarehouseName(
                  text: 'Direccion',
                  isAccending:
                      selectedMenu == SampleItem.itemTwo ? isAccending : null,
                ),
              ),
            ]);
  }
}

class _SortWarehouseName extends StatelessWidget {
  final bool? isAccending;
  final String text;

  const _SortWarehouseName(
      {super.key, required this.text, required this.isAccending});

  @override
  Widget build(BuildContext context) {
    Color color = Colors.white;
    final List<Widget> children = [
      const SizedBox(width: 8),
      Text(text, style: TextStyle(color: color))
    ];

    if (isAccending != null) {
      children.insert(
          0,
          Icon(
            isAccending != null && isAccending == true
                ? Icons.arrow_upward
                : Icons.arrow_downward,
            color: color,
          ));
    }

    return Row(
      children: children,
    );
  }
}
