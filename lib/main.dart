import 'package:flutter/material.dart';
import 'package:flutter_app_erp/theme/dark/theme_dark.dart';
import 'package:flutter_app_erp/theme/ligth/theme_ligth.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app_erp/router_app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:flutter_app_erp/providers/auth_provider.dart";

Future main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GoRouteInformationProvider(
            initialLocation: "/",
            initialExtra: "/",
          ),
        )
      ],

      child: MaterialApp.router(
        routerConfig: router,
        title: 'Flutter Demo',
        theme: themeLight,
        darkTheme: themeDark,
      ),

      // home:   // const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
