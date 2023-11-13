import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app_erp/widgets/typography.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';

Widget listItemRouter({
  required BuildContext context,
  required String pathname,
  String? title,
  Widget? leading,
}) {
  final currentRoute = ModalRoute.of(context)!.settings.name;
  final bool selected = currentRoute == pathname;
  final String color = selected ? "primary" : "inherit";

  return ListTile(
    leading: leading,
    selected: selected,
    title: TypographyApp(
      text: title,
      variant: "subtitle2",
      color: color,
    ),
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

  Widget buildListOptions(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: [
        listItemRouter(
          pathname: "/",
          title: "Inicio",
          context: context,
          leading: const Icon(Icons.dashboard),
        ),
        listItemRouter(
          title: "Impuestos",
          pathname: "/taxes",
          context: context,
          leading: const Icon(Icons.percent),
        ),
        listItemRouter(
          title: "Deposito",
          pathname: "/warehouse",
          context: context,
          leading: const Icon(Icons.warehouse),
        ),
        listItemRouter(
          title: "Monedas",
          pathname: "/currencies",
          context: context,
          leading: const Icon(Icons.currency_exchange),
        ),
      ],
    );
  }

  Widget buildUserDrawer(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final user = authProvider.getCurrentUser();
    final String fullName =
        user == null ? "Sin nombre" : "${user!.firstName} ${user.lastName}";
    final String email = user == null ? "Sin email" : user.email;
    final String username = user == null ? "Sin usuario" : user.username;

    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.account_circle,
                size: 80,
                color: Colors.white,
              ),
              TypographyApp(
                text: fullName,
                color: "white",
                variant: "subtitle1",
              ),
              TypographyApp(
                text: username,
                color: "white",
              ),
              TypographyApp(
                text: email,
                color: "white",
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).colorScheme.primary;

    return Drawer(
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  color: color,
                  height: 150,
                  child: buildUserDrawer(context),
                ),
                Expanded(
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: buildListOptions(context),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ListTile(
                    leading: const Icon(Icons.exit_to_app),
                    title: const TypographyApp(
                      text: "Cerrar Sesión",
                      variant: "subtitle2",
                    ),
                    onTap: () => onSignout(context),
                  ),
                ),
              ],
            ),
          ),

          /*SizedBox(
            height: 100,
            child: ,
          )*/
        ],
      ),
    );
  }
}
