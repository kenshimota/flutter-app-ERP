import 'package:flutter/material.dart';

ThemeData themeDark() => ThemeData(
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
        seedColor: Color.fromARGB(255, 224, 20, 5),
        primary: Color.fromARGB(255, 224, 20, 5),
        surface: Color.fromARGB(255, 224, 20, 5),
        onPrimary: Color.fromARGB(255, 224, 20, 5),
        brightness: Brightness.dark,
      ),

      scaffoldBackgroundColor: Color(0x33333333),

      drawerTheme: const DrawerThemeData(
        // shadowColor: ,
        // Definir los colores deseados para el Drawer
        backgroundColor:Colors.black,
        // Otros atributos del tema
      ),

      dialogTheme: const DialogTheme(
        // Personaliza los atributos del Dialog
        backgroundColor: Colors.black,
        // Otros atributos del DialogTheme
      ),

      iconTheme: const IconThemeData(color: Color.fromARGB(255, 224, 20, 5)),

      inputDecorationTheme: InputDecorationTheme(
        iconColor: Color(0x44444444),
        fillColor: Color(0x44444444),
        filled: true,
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
          iconColor: Color.fromARGB(255, 224, 20, 5),
          foregroundColor: Color.fromARGB(255, 224, 20, 5),
        ),
      ),

      dialogBackgroundColor: Color(0x22222222),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            foregroundColor: Color.fromARGB(255, 224, 20, 5),
            shape: ContinuousRectangleBorder(
              side: const BorderSide(color: Color.fromARGB(255, 224, 20, 5), width: 1),
              borderRadius: BorderRadius.circular(10),
            )),
      ),

      useMaterial3: true,
    );
