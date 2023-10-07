import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_erp/widgets/typography.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';

Widget listItemRouter({
  required BuildContext context,
  required String pathname,
  String? title,
}) {
  final currentRoute = ModalRoute.of(context)!.settings.name;
  final bool selected = currentRoute == pathname;

  debugPrint(selected.toString());
  debugPrint("$pathname -> $title");

  return ListTile(
    selected: currentRoute == pathname,
    title: TypographyApp(text: title, variant: "body"),
    onTap: () => GoRouter.of(context).go(pathname),
  );
}

class DrawerApp extends StatelessWidget {
  final VoidCallback onClose;

  const DrawerApp({super.key, required this.onClose});

  onSignout(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.signOut();
    onClose();

    GoRouter.of(context).go("/login");
  }

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)!.settings.name;

    debugPrint(currentRoute);

    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          listItemRouter(
            pathname: "/",
            title: "Inicio",
            context: context,
          ),
          listItemRouter(
            title: "Impuestos",
            pathname: "/taxes",
            context: context,
          ),
          ListTile(
            title: const TypographyApp(text: "Cerrar Sesión"),
            onTap: () => onSignout(context),
          )
        ],
      ),
    );
  }
}
