import 'package:flutter/material.dart';

class DrawerApp extends StatelessWidget {
  final List<Widget> children;
  final VoidCallback onClose;

  const DrawerApp({super.key, required this.onClose, required this.children});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ...children,
            const Text('This is the Drawer'),
            ElevatedButton(
              onPressed: onClose,
              child: const Text('Close Drawer'),
            ),
          ],
        ),
      ),
    );
  }
}
