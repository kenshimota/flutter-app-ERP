import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';

class DrawerApp extends StatelessWidget {
  final List<Widget> children;
  final VoidCallback onClose;

  const DrawerApp({super.key, required this.onClose, required this.children});

  onSignup(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.signOut();
    onClose();
  }

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
              onPressed: () => onSignup(context),
              child: const Text('Close Drawer'),
            ),
          ],
        ),
      ),
    );
  }
}
