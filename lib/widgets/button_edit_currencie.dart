import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/dialogo_edit_currencie.dart';
import 'package:flutter_app_erp/core/response/currencies/currencies_response.dart';

class ButtonEditCurrencie extends StatelessWidget {
  final void Function()? onSave;
  final CurrenciesResponse currencie;

  const ButtonEditCurrencie({
    super.key,
    this.onSave,
    required this.currencie,
  });

    onNewCurrencie(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialgEditCurrencie(
        currencie: currencie,
        onSave: onSave,
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return IconButton(
      onPressed: () => onNewCurrencie(context), 
      icon: const Icon(Icons.edit),);
    }
  }

  class TextButtonEditCurrencie extends StatelessWidget {
  final void Function()? onSave;
  final CurrenciesResponse currencie;
  final Color? color;

  const TextButtonEditCurrencie({
    super.key,
    this.onSave,
    this.color,
    required this.currencie,
  });

  onNewCurrencie(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialgEditCurrencie(
        currencie: currencie,
        onSave: onSave,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final style =
        color == null ? null : TextButton.styleFrom(foregroundColor: color);

    return TextButton(
      style: style,
      onPressed: () => onNewCurrencie(context),
      child: const Text('Editar'),
    );
  }
}