import "dart:core";
import 'package:flutter_app_erp/screens/inventories_screen.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app_erp/screens/home_screen.dart';
import 'package:flutter_app_erp/screens/taxes_screen.dart';
import 'package:flutter_app_erp/screens/signin_screen.dart';
import 'package:flutter_app_erp/screens/signup_screen.dart';
import 'package:flutter_app_erp/screens/products_screen.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:flutter_app_erp/screens/warehouse_screen.dart';
import 'package:flutter_app_erp/screens/currencies_screen.dart';
import 'package:flutter_app_erp/screens/reset_password_screen.dart';
import 'package:flutter_app_erp/screens/orders_screen.dart';

final Set<String> routesWithoutSignin = <String>{
  "/signin",
  "/signup",
  "/reset_password"
};

final router = GoRouter(
  routes: [
    GoRoute(path: "/", builder: (context, state) => const HomeScreen()),
    GoRoute(path: "/taxes", builder: (context, state) => const TaxesScreen()),
    GoRoute(path: "/signin", builder: (context, state) => const SigninScreen()),
    GoRoute(path: "/signup", builder: (context, state) => const SignupScreen()),
    GoRoute(
      path: "/warehouse",
      builder: (context, state) => const WarehouseScreen(),
    ),
    GoRoute(
      path: "/currencies",
      builder: (context, state) => const CurrenciesScreen(),
    ),
    GoRoute(
      path: "/products",
      builder: (context, state) => const ProductsScreen(),
    ),
    GoRoute(
      path: "/reset_password",
      builder: (context, state) => const ResetPasswordScreen(),
    ),
    GoRoute(
      path: "/inventories",
      builder: (context, state) => const InventoriesScreen(),
    ),
    GoRoute(
      path: "/orders",
      builder: (context, state) => const OrdersScreen(),
    ),
  ],
  redirect: (context, state) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final String path = state.uri.toString();

    if (!authProvider.hasSession() && !routesWithoutSignin.contains(path)) {
      return '/signin';
    }

    if (authProvider.hasSession() && routesWithoutSignin.contains(path)) {
      return "/";
    }

    return null;
  },
);
