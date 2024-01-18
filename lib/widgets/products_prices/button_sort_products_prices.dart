import 'package:flutter/material.dart';

enum SampleItem {
  itemOne,
  itemTwo,
  itemThree,
  itemFour,
  itemFive,
}

class ButtonSortProductsPrices extends StatelessWidget {
  final Function(Map<String, String>)? onOrden;
  const ButtonSortProductsPrices({
    super.key,
    this.onOrden,
  });

  @override
  Widget build(BuildContext context) {
    return PopupButtonProductsPrices(
      onOrden: onOrden,
    );
  }
}

class PopupButtonProductsPrices extends StatefulWidget {
  final Function(Map<String, String>)? onOrden;

  const PopupButtonProductsPrices({
    super.key,
    this.onOrden,
  });

  @override
  State<PopupButtonProductsPrices> createState() =>
      _PopupButtonProductsPricesState();
}

class _PopupButtonProductsPricesState extends State<PopupButtonProductsPrices> {
  SampleItem? selectedMenu;
  bool isAccending = false;

  onSort(SampleItem item) {
    final b = !isAccending;
    final index = item.index;
    final list = <String>[
      "currency_id",
      "product_id",
      "price",
      "created_at",
      "updated_at",
    ];

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
                  child: _SortProductsPricesName(
                      text: 'Moneda',
                      isAccending: selectedMenu == SampleItem.itemOne
                          ? isAccending
                          : null)),
              PopupMenuItem<SampleItem>(
                  value: SampleItem.itemTwo,
                  child: _SortProductsPricesName(
                      text: 'Producto',
                      isAccending: selectedMenu == SampleItem.itemTwo
                          ? isAccending
                          : null)),
              PopupMenuItem<SampleItem>(
                  value: SampleItem.itemThree,
                  child: _SortProductsPricesName(
                      text: 'Precio',
                      isAccending: selectedMenu == SampleItem.itemThree
                          ? isAccending
                          : null)),
              PopupMenuItem<SampleItem>(
                  value: SampleItem.itemFour,
                  child: _SortProductsPricesName(
                      text: 'Fecha de creado',
                      isAccending: selectedMenu == SampleItem.itemFour
                          ? isAccending
                          : null)),
              PopupMenuItem<SampleItem>(
                  value: SampleItem.itemFive,
                  child: _SortProductsPricesName(
                      text: 'Fechas de actualizado',
                      isAccending: selectedMenu == SampleItem.itemFive
                          ? isAccending
                          : null)),
            ]);
  }
}

class _SortProductsPricesName extends StatelessWidget {
  final bool? isAccending;
  final String text;

  const _SortProductsPricesName(
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
