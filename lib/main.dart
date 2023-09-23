import 'package:flutter/material.dart';
import 'package:flutter_app_erp/router_app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.

        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          // primary: Colors.white,
          surface: Colors.purple,
          onPrimary: Colors.purple,
        ),

        iconTheme: const IconThemeData(color: Colors.purple),

        inputDecorationTheme: InputDecorationTheme(
          iconColor: Colors.purple,
          contentPadding: const EdgeInsets.all(20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100.0),
          ),
        ),

        scaffoldBackgroundColor: const Color(0xFFdddddd),
        /*Color.fromARGB(
            255, 218, 200, 250), // const Color(0xFFDDDDDD),*/

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),

        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            iconColor: Colors.purple,
            foregroundColor: Colors.purple,
          ),
        ),

        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              foregroundColor: Colors.purple,
              shape: ContinuousRectangleBorder(
                side: const BorderSide(color: Colors.purple, width: 1),
                borderRadius: BorderRadius.circular(10),
              )),
        ),

        useMaterial3: true,
      ),
      // home:   // const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
