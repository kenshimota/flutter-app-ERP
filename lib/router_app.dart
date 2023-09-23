import 'package:go_router/go_router.dart';

import 'package:flutter_app_erp/screens/signin_screen.dart';
import 'package:flutter_app_erp/screens/signup_screen.dart';
import 'package:flutter_app_erp/screens/home_screen.dart';

final GoRouter router = GoRouter(routes: [
  GoRoute(path: "/", builder: (context, state) => const HomeScreen()),
  GoRoute(path: "/signin", builder: (context, state) => const SigninScreen()),
  GoRoute(path: "/signup", builder: (context, state) => const SignupScreen())
]);
