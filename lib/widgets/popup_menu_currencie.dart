import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/response/currencies/currencies_response.dart';

import 'package:flutter_app_erp/widgets/button_delete_currencie.dart';

import 'package:flutter_app_erp/widgets/dialogo_edit_currencie.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class PopupMenuCurrencie extends StatelessWidget {
  final void Function()? onAfterChange;
  final CurrenciesResponse currencie;

  const PopupMenuCurrencie(
      {super.key, this.onAfterChange, required this.currencie});

  @override
  Widget build(BuildContext context) {
    return PopupCurrencie(onAfterChange: onAfterChange, currencie: currencie);
  }
}

class PopupCurrencie extends StatefulWidget {
  final void Function()? onAfterChange;
  final CurrenciesResponse currencie;

  const PopupCurrencie({
    super.key,
    this.onAfterChange,
    required this.currencie,
  });

  @override
  State<PopupCurrencie> createState() => _PopupCurrencieState();
}

class _PopupCurrencieState extends State<PopupCurrencie> {
  SampleItem? selectedMenu;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SampleItem>(
      initialValue: selectedMenu,
      onSelected: (SampleItem item) {
        Widget Function(BuildContext)? builder;
        setState(() {
          selectedMenu = item;
        });

        if (item == SampleItem.itemOne) {
          builder = (context) => AlertDialgEditCurrencie(
                currencie: widget.currencie,
                onSave: widget.onAfterChange,
              );
        } else if (item == SampleItem.itemTwo) {
          builder = (context) => AlertDialogDelete(
                currencieId: widget.currencie.id,
                onAfterDelete: widget.onAfterChange,
              );
        }

        if (builder != null) {
          showDialog(context: context, builder: builder);
        }
      },
      itemBuilder: (
        BuildContext context,
      ) =>
          <PopupMenuEntry<SampleItem>>[
        const PopupMenuItem<SampleItem>(
          value: SampleItem.itemOne,
          child: Text(
            'Editar',
            style: TextStyle(color: Colors.white),
          ),
        ),
        const PopupMenuItem<SampleItem>(
          value: SampleItem.itemTwo,
          child: Text(
            'Eliminar',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
