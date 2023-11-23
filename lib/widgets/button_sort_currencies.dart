import 'package:flutter/material.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class ButtonSortCurrencies extends StatelessWidget {
  final Function(Map<String, String>)? onOrden;
  const ButtonSortCurrencies({super.key, this.onOrden});

  @override
  Widget build(BuildContext context) {
    return PopupButtonCurrencies(
      onOrden: onOrden,
    );
  }
}

class PopupButtonCurrencies extends StatefulWidget {
  final Function(Map<String, String>)? onOrden;
  const PopupButtonCurrencies({super.key, this.onOrden});

  @override
  State<PopupButtonCurrencies> createState() => _PopupButtonCurrenciesState();
}

class _PopupButtonCurrenciesState extends State<PopupButtonCurrencies> {
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
                child: _SortCurrencieName(
                    text: 'Nombre',
                    isAccending: selectedMenu == SampleItem.itemOne
                        ? isAccending
                        : null),
              ),
              PopupMenuItem<SampleItem>(
                value: SampleItem.itemTwo,
                child: _SortCurrencieName(
                  text: 'Simbolo',
                  isAccending:
                      selectedMenu == SampleItem.itemTwo ? isAccending : null,
                ),
              ),
              PopupMenuItem<SampleItem>(
                value: SampleItem.itemTwo,
                child: _SortCurrencieName(
                  text: 'Codigo',
                  isAccending:
                      selectedMenu == SampleItem.itemTwo ? isAccending : null,
                ),
              ),
            ]);
  }
}

class _SortCurrencieName extends StatelessWidget {
  final bool? isAccending;
  final String text;

  const _SortCurrencieName(
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
