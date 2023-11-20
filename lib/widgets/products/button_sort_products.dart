import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/typography.dart';

enum SampleItem {
  itemOne,
  itemTwo,
  itemThree,
  itemFour,
  itemFive,
  itemSix,
  itemSeven,
  itemEight
}

class ButtonSortProducts extends StatelessWidget {
  final Function(Map<String, String>)? onOrden;
  const ButtonSortProducts({super.key, this.onOrden});

  @override
  Widget build(BuildContext context) {
    return PopupButtonTaxes(
      onOrden: onOrden,
    );
  }
}

class PopupButtonTaxes extends StatefulWidget {
  final Function(Map<String, String>)? onOrden;
  const PopupButtonTaxes({super.key, this.onOrden});

  @override
  State<PopupButtonTaxes> createState() => _PopupButtonTaxesState();
}

class _PopupButtonTaxesState extends State<PopupButtonTaxes> {
  SampleItem? selectedMenu;
  bool isAccending = false;

  onSort(SampleItem item) {
    final b = !isAccending;
    final index = item.index;
    final list = <String>[
      "code",
      "name",
      "bar_code",
      "stock",
      "reserve",
      "tax_id",
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
                child: _SortProductsName(
                    text: 'Codigo',
                    isAccending: selectedMenu == SampleItem.itemOne
                        ? isAccending
                        : null),
              ),
              PopupMenuItem<SampleItem>(
                value: SampleItem.itemTwo,
                child: _SortProductsName(
                  text: 'Nombre',
                  isAccending:
                      selectedMenu == SampleItem.itemTwo ? isAccending : null,
                ),
              ),
              PopupMenuItem<SampleItem>(
                value: SampleItem.itemThree,
                child: _SortProductsName(
                  text: 'Codigo Barra',
                  isAccending:
                      selectedMenu == SampleItem.itemThree ? isAccending : null,
                ),
              ),
              PopupMenuItem<SampleItem>(
                value: SampleItem.itemFour,
                child: _SortProductsName(
                  text: 'Existencia',
                  isAccending:
                      selectedMenu == SampleItem.itemFour ? isAccending : null,
                ),
              ),
              PopupMenuItem<SampleItem>(
                value: SampleItem.itemFive,
                child: _SortProductsName(
                  text: 'Reserva',
                  isAccending:
                      selectedMenu == SampleItem.itemFive ? isAccending : null,
                ),
              ),
              PopupMenuItem<SampleItem>(
                value: SampleItem.itemSix,
                child: _SortProductsName(
                  text: 'Impuesto',
                  isAccending:
                      selectedMenu == SampleItem.itemSix ? isAccending : null,
                ),
              ),
              PopupMenuItem<SampleItem>(
                value: SampleItem.itemSeven,
                child: _SortProductsName(
                  text: 'Fecha de creación',
                  isAccending:
                      selectedMenu == SampleItem.itemSeven ? isAccending : null,
                ),
              ),
              PopupMenuItem<SampleItem>(
                value: SampleItem.itemEight,
                child: _SortProductsName(
                  text: 'Fecha de actualización',
                  isAccending:
                      selectedMenu == SampleItem.itemEight ? isAccending : null,
                ),
              ),
            ]);
  }
}

class _SortProductsName extends StatelessWidget {
  final bool? isAccending;
  final String text;

  const _SortProductsName(
      {super.key, required this.text, required this.isAccending});

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [
      const SizedBox(width: 8),
      TypographyApp(variant: "body1", text: text, color: "white"),
    ];

    if (isAccending != null) {
      children.insert(
          0,
          Icon(
            isAccending != null && isAccending == true
                ? Icons.arrow_upward
                : Icons.arrow_downward,
            color: Colors.white,
          ));
    }

    return Row(
      children: children,
    );
  }
}
