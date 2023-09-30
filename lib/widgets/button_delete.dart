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
  return Dialog(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('This is a typical dialog.'),
          const SizedBox(height: 15),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          ),
        ],
      ),
    ),
  );
}
