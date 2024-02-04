import 'package:flutter/material.dart';

ThemeData themeLight() => ThemeData(
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


      colorScheme:  ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 224, 20, 5),
        surface: const Color.fromARGB(255, 224, 20, 5),
        onPrimary: const Color.fromARGB(255, 224, 20, 5),
        error: const Color.fromARGB(255, 224, 20, 5),
        brightness: Brightness.light,
      ),

      scaffoldBackgroundColor: const Color(0xDDDDDDDD),

      drawerTheme: const DrawerThemeData(
        backgroundColor: Colors.white,
      ),

      dialogTheme: const DialogTheme(
        backgroundColor: Colors.white,
      ),

      iconTheme: const IconThemeData(color: Color.fromARGB(255, 224, 20, 5),),

      inputDecorationTheme: InputDecorationTheme(
        iconColor: const Color.fromARGB(255, 224, 20, 5),
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
      ),

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
          iconColor: const Color.fromARGB(255, 224, 20, 5),
          foregroundColor:const Color.fromARGB(255, 224, 20, 5),
        ),
      ),

      dialogBackgroundColor: Colors.white,

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            foregroundColor: const Color.fromARGB(255, 224, 20, 5),
            shape: ContinuousRectangleBorder(
              side: const BorderSide(color: Color.fromARGB(255, 224, 20, 5), width: 1),
              borderRadius: BorderRadius.circular(10),
            )),
      ),

      useMaterial3: true,
    );
