import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/elevated_button_future.dart';

class ButtonCreateTax extends StatelessWidget {
  final Icon icon;
  const ButtonCreateTax({super.key, required this.icon});
  @override
  Widget build(BuildContext context) {
    return ElevatedButtonFuture(
      onPressed: () => {},
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
