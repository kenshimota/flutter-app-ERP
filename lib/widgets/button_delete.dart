// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class DeleteButtonTaxes extends StatefulWidget {
  const DeleteButtonTaxes({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DeleteButtonTaxesState createState() => _DeleteButtonTaxesState();
}

class _DeleteButtonTaxesState extends State<DeleteButtonTaxes> {
  onClick() {
    debugPrint('Hola como estas');
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => showDialog(
        context: context,
        builder: (BuildContext context) => _DialogDeleteTaxes(context),
      ),
      icon: const Icon(Icons.delete),
    );
  }
}

Widget _DialogDeleteTaxes(BuildContext context) {
  return AlertDialog(
  title: const Text('Eliminar'),
  content: const Text('Esta seguro que deseas eliminar este elemento de la tabla?'),
  actions: [
    ButtonBar(
      children: [
        ElevatedButton(
          onPressed: () {
            // Acción del primer botón
          },
          child: const Text('Si'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('No'),
        ),
      ],
    ),
  ],
);
}
