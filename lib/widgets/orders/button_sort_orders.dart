import 'package:flutter/material.dart';

enum SampleItem {
  itemOne,
  itemTwo,
  itemThree,
  itemFour,
  itemFive,
  itemSix,
  itemSeven,
  itemEight,
  itemNine,
  itemTen,
}

class ButtonSortOrders extends StatelessWidget {
  final Function(Map<String, String>)? onOrden;

  const ButtonSortOrders({
    super.key,
    this.onOrden,
  });

  @override
  Widget build(BuildContext context) {
    return PopupButtonOrders(
      onOrden: onOrden,
    );
  }
}

class PopupButtonOrders extends StatefulWidget {
  final Function(Map<String, String>)? onOrden;

  const PopupButtonOrders({
    super.key,
    this.onOrden,
  });

  @override
  State<PopupButtonOrders> createState() => _PopupButtonOrdersState();
}

class _PopupButtonOrdersState extends State<PopupButtonOrders> {
  SampleItem? selectedMenu;
  bool isAccending = false;

  onSort(SampleItem item) {
    final b = !isAccending;
    final index = item.index;
    final list = <String>[
      "number",
      "subtotal",
      "name",
      "tax_amount",
      "total",
      "currency_id",
      "user",
      "products_count",
      "created_at",
      "updated_at"
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
          child: _SortOrdersName(
              text: 'Codigo',
              isAccending:
                  selectedMenu == SampleItem.itemOne ? isAccending : null),
        ),
        PopupMenuItem<SampleItem>(
          value: SampleItem.itemTwo,
          child: _SortOrdersName(
            text: 'Subtotal',
            isAccending:
                selectedMenu == SampleItem.itemTwo ? isAccending : null,
          ),
        ),
         PopupMenuItem<SampleItem>(
          value: SampleItem.itemThree,
          child: _SortOrdersName(
            text: 'Nombre',
            isAccending:
                selectedMenu == SampleItem.itemThree ? isAccending : null,
          ),
        ),
         PopupMenuItem<SampleItem>(
          value: SampleItem.itemFour,
          child: _SortOrdersName(
            text: 'Monto de impuesto',
            isAccending:
                selectedMenu == SampleItem.itemFour ? isAccending : null,
          ),
        ),
         PopupMenuItem<SampleItem>(
          value: SampleItem.itemFive,
          child: _SortOrdersName(
            text: 'Total',
            isAccending:
                selectedMenu == SampleItem.itemFive ? isAccending : null,
          ),
        ),
         PopupMenuItem<SampleItem>(
          value: SampleItem.itemSix,
          child: _SortOrdersName(
            text: 'Moneda',
            isAccending:
                selectedMenu == SampleItem.itemSix ? isAccending : null,
          ),
        ),
         PopupMenuItem<SampleItem>(
          value: SampleItem.itemSeven,
          child: _SortOrdersName(
            text: 'Usuario',
            isAccending:
                selectedMenu == SampleItem.itemSeven ? isAccending : null,
          ),
        ),
         PopupMenuItem<SampleItem>(
          value: SampleItem.itemEight,
          child: _SortOrdersName(
            text: 'Cantidad de productos',
            isAccending:
                selectedMenu == SampleItem.itemEight ? isAccending : null,
          ),
        ),
         PopupMenuItem<SampleItem>(
          value: SampleItem.itemNine,
          child: _SortOrdersName(
            text: 'Fecha de creacion',
            isAccending:
                selectedMenu == SampleItem.itemNine ? isAccending : null,
          ),
        ),
         PopupMenuItem<SampleItem>(
          value: SampleItem.itemTen,
          child: _SortOrdersName(
            text: 'Fecha de actualizacion',
            isAccending:
                selectedMenu == SampleItem.itemTen ? isAccending : null,
          ),
        ),
      ],
    );
  }
}

class _SortOrdersName extends StatelessWidget {
  final bool? isAccending;
  final String text;

  const _SortOrdersName(
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
