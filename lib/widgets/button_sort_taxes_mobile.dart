import 'package:flutter/material.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class ButtonSortTaxes extends StatelessWidget {
  const ButtonSortTaxes({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupButtonTaxes();
  }
}

class PopupButtonTaxes extends StatefulWidget {
  const PopupButtonTaxes({super.key});

  @override
  State<PopupButtonTaxes> createState() => _PopupButtonTaxesState();
}

class _PopupButtonTaxesState extends State<PopupButtonTaxes> {
  SampleItem? selectedMenu;
  bool isAccending = false;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SampleItem>(
        icon: const Icon(Icons.sort),
        initialValue: selectedMenu,
        onSelected: (SampleItem item) {
          // Widget Function(BuildContext)? builder;

          setState(() {
            selectedMenu = item;
            isAccending = !isAccending;
          });
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
              PopupMenuItem<SampleItem>(
                value: SampleItem.itemOne,
                child: _SortTaxesName(text: 'Nombre', isAccending: selectedMenu == SampleItem.itemOne ? isAccending : null),
              ),
              PopupMenuItem<SampleItem>(
                value: SampleItem.itemTwo,
                child: _SortTaxesName(
                  text: 'Impuesto',
                  isAccending: selectedMenu == SampleItem.itemTwo ?  isAccending :   null,
                ),
              ),
            ]);
  }
}


class _SortTaxesName extends StatelessWidget {
  final bool? isAccending;
  final String text;

  const _SortTaxesName({super.key, required this.text, required this.isAccending});

  @override
  Widget build(BuildContext context) {
    final Color color = Colors.white;
    final List<Widget> children = [const SizedBox(width: 8), Text(text, style: TextStyle(color: color))];

    if(isAccending != null) {
      children.insert(0, Icon(isAccending != null && isAccending == true ? Icons.arrow_upward : Icons.arrow_downward, color: color,));
    }
    
    return Row(
      children: children,
    );
  }
}
