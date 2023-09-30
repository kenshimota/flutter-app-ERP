import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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

    GoRouter.of(context).go("/login");
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
              child: const Text('Cerrar Sessión'),
            ),
          ],
        ),
      ),
    );
  }
}
