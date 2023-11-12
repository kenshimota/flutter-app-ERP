import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/elevated_button_future.dart';

class ButtonCreateWarehouse extends StatelessWidget {
  final Icon icon;
  final Future? future;
  final void Function()? onClick;

  const ButtonCreateWarehouse({
    super.key,
    this.future,
    this.onClick,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButtonFuture(
      future: future,
      onPressed: onClick,
      child: Row(
        children: [
          icon,
          const SizedBox(
            width: 5,
          ),
          const Text('Guardar'),
        ],
      ),
    );
  }
}