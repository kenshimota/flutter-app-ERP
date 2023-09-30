import "dart:core";
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app_erp/screens/home_screen.dart';
import 'package:flutter_app_erp/screens/signin_screen.dart';
import 'package:flutter_app_erp/screens/signup_screen.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';

final Set<String> routesWithoutSignin = <String>{
  "/signin",
  "/signup",
};

final router = GoRouter(
  routes: [
    GoRoute(path: "/", builder: (context, state) => const HomeScreen()),
    GoRoute(path: "/signin", builder: (context, state) => const SigninScreen()),
    GoRoute(path: "/signup", builder: (context, state) => const SignupScreen())
  ],
  redirect: (context, state) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final String path = state.uri.toString();

    debugPrint(authProvider.hasSession().toString());
    debugPrint(path);

    if (!authProvider.hasSession() && !routesWithoutSignin.contains(path)) {
      return '/signin';
    }

    if (authProvider.hasSession() && routesWithoutSignin.contains(path)) {
      return "/";
    }

    return null;
  },
);
