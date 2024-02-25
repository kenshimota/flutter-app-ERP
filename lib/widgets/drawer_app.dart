import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/constants/roles_constants.dart';
import 'package:flutter_app_erp/widgets/protected_child.dart';
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

Widget listItemRouterProtected({
  required BuildContext context,
  required String pathname,
  required List<String> roles,
  String? title,
  Widget? leading,
}) {
  return ProtectedChild(
    roles: roles,
    child: listItemRouter(
      context: context,
      pathname: pathname,
      title: title,
      leading: leading,
    ),
  );
}

class DrawerApp extends StatelessWidget {
  final VoidCallback onClose;

  const DrawerApp({super.key, required this.onClose});

  onSignout(BuildContext context) {
    onClose();

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.signOut();

    GoRouter.of(context).go("/login");
  }

  Widget buildListOptions(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: [
        listItemRouterProtected(
          pathname: "/",
          title: "Inicio",
          context: context,
          leading: const Icon(Icons.dashboard),
          roles: [
            RolesConstants.manager(),
            RolesConstants.invetoryPerson(),
            RolesConstants.salePerson()
          ],
        ),
        listItemRouterProtected(
          title: "Impuestos",
          pathname: "/taxes",
          context: context,
          roles: [RolesConstants.manager()],
          leading: const Icon(Icons.percent),
        ),
        listItemRouterProtected(
          title: "Deposito",
          pathname: "/warehouse",
          context: context,
          roles: [RolesConstants.manager(), RolesConstants.invetoryPerson()],
          leading: const Icon(Icons.warehouse),
        ),
        listItemRouterProtected(
          title: "Monedas",
          pathname: "/currencies",
          context: context,
          roles: [RolesConstants.manager()],
          leading: const Icon(Icons.currency_exchange),
        ),
        listItemRouterProtected(
          context: context,
          title: "Productos",
          pathname: "/products",
          roles: [RolesConstants.manager(), RolesConstants.invetoryPerson()],
          leading: const Icon(Icons.engineering),
        ),
        listItemRouterProtected(
          context: context,
          title: "Inventario",
          pathname: "/inventories",
          roles: [RolesConstants.manager(), RolesConstants.invetoryPerson()],
          leading: const Icon(Icons.inventory),
        ),
        listItemRouter(
          context: context,
          title: "Pedido",
          pathname: "/orders",
          leading: const Icon(Icons.shop),
        ),
        listItemRouterProtected(
          context: context,
          title: "Precios",
          pathname: "/products_prices",
          leading: const Icon(Icons.price_change),
          roles: [RolesConstants.manager()],
        ),
        listItemRouterProtected(
          context: context,
          title: "Usuarios",
          pathname: "/users",
          leading: const Icon(Icons.person),
          roles: [RolesConstants.manager()],
        )
      ],
    );
  }

  Widget buildUserDrawer(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final user = authProvider.getCurrentUser();
    final String fullName =
        user == null ? "Sin nombre" : "${user.firstName} ${user.lastName}";
    final String email = user == null ? "Sin email" : user.email;
    final String username = user == null ? "Sin usuario" : user.username;

    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/img/icon-white.png"),
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
        ],
      ),
    );
  }
}
